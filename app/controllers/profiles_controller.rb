class ProfilesController < ApplicationController
  before_action :params_user, only: %i[create new edit update previous]

  def new
    if current_user?
      @profile = @user.profile || Profile.new(user: @user, step: 2, validation: 0)
      @profile.step = 2 if @profile.step < 2
      @profile.save!
      @step = @profile.step
      render :edit
    else
      redirect_to new_user_profile_path(@user)
    end
  end

  def show
  end

  def edit
    if current_user?
      @profile = @user.profile
      @profile.save!
      @step = @profile.step
    else
      redirect_to edit_user_profile_path(@user)
    end
  end

  def update
    if current_user?
      @profile = @user.profile
      @profile.step += 1

      if @profile.step5?
        @user.user_wishes.destroy_all
        wishes = Wish.all.to_a
        wishes.each_with_index do |wish, index|
          UserWish.create( user: @user, wish: wish) if profile_params[("need"<<index.to_s).to_sym] == "true"
        end
        @profile.save
        redirect_to edit_user_profile_path
      else
        if @profile.update(profile_params)
          redirect_to edit_user_profile_path
          if @profile.step6?
            UserMailer.new_registration(@user).deliver_now
          end
        else
          notice = ""
          @profile.errors.messages.each do |key, value|
            notice << value.first << ". <br/>"
          end
          redirect_to edit_user_profile_path, alert: notice
        end
      end
    end
  end

  def validate
    @profile = Profile.find(params[:id])
    @profile.validation = 1
    if @profile.save
      flash[:notice] = "Profile validé"
      redirect_to admin_validations_path
      UserMailer.validation(@profile.user).deliver_now
    else
      flash[:alert] = "Validation échouée, vérifier les logs"
      redirect_to admin_validations_path
    end
  end

  def request_update
    @profile = Profile.find(params[:id])
    @profile.step = 2
    @profile.validation = 2
    if true
      @updates_requested = request_update_params
      UserMailer.request_update(@profile.user, @updates_requested).deliver_now
      flash[:notice] = "Profile envoyé en attente de modification"
      redirect_to admin_validations_path
    end
  end

  def previous
    @profile = @user.profile
    @profile.step -= 1
    @profile.save!
    redirect_to edit_user_profile_path(@user)
  end

  private

  def params_user
    @user = current_user
  end

  def profile_params
    params.require(:profile).permit(:address, :kids, :mother_first_name, :father_first_name, :user, :phone, :noneed, :need0, :need1, :need2, :need3, :photo, :lat, :lng )
  end

  def request_update_params
    params.permit(:address, :kids, :parent1, :parent2, :phone, :photo)
  end
end
