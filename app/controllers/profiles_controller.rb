class ProfilesController < ApplicationController
  before_action :params_user, only: %i[create new edit update previous]

  def new
    @profile = @user.profile || Profile.new(user: @user, step: 2)
    @profile.step = 2 if @profile.step < 2
    @profile.save!
    @step = @profile.step
    render :edit
  end

  def show

  end

  def edit
    @profile = @user.profile
    @profile.save!
    @step = @profile.step
  end

  def update
    @profile = @user.profile
    @profile.step += 1

    if @profile.step5?
      @user.user_wishes.destroy_all
      wishes = Wish.all.to_a
      wishes.each do |wish|
        UserWish.create( user: @user, wish: wish, status: profile_params[("need"<<wish.number.to_s).to_sym] )
      end
      @profile.save
      redirect_to edit_user_profile_path
    else
      if @profile.update(profile_params)
        redirect_to edit_user_profile_path
      else
        notice = ""
        @profile.errors.messages.each do |key, value|
          notice << value.first << ". <br/>"
        end
        redirect_to edit_user_profile_path, alert: notice
      end
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
    params.require(:profile).permit(:address, :kids, :mother_first_name, :father_first_name, :user, :phone, :need0, :need1, :need2, :need3, :photo)
  end
end
