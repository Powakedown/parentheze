class ProfilesController < ApplicationController
  before_action :params_user, only: %i[create new edit update previous]

  def show

  end

  def edit
    @profile = @user.profile || Profile.new(user: @user, step: 2)
    @profile.save!
    @step = @profile.step
  end

  def update
    @profile = @user.profile
    @profile.step += 1
    if @profile.update(profile_params)
      redirect_to edit_user_profile_path
    else
      notice = ""
      @profile.errors.messages.each do |key, value|
        notice << "- " << value.first << ". <br/>"
      end
      redirect_to edit_user_profile_path, alert: notice

    end

    if @profile.step == 5
      # UserWish.create( user: @user, wish: ) if params[:profile][:need1] == 1

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
    params.require(:profile).permit(:address, :kids, :mother_first_name, :father_first_name, :user, :phone, :need1, :need2, :need3, :need4, :photo)
  end
end
