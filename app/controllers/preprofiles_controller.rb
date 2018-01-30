class PreprofilesController < ApplicationController
  before_action :params_user, only: %i[update previous]

  def update
    @pp = @user.preprofile
    if @pp.update(preprofile_params)
      @pp.step += 1
      @pp.save
      redirect_to new_user_profile_path
    else
      redirect_to new_user_profile_path
    end
  end

  def previous
    @pp = @user.preprofile
    @pp.step -= 1
    @pp.save
    redirect_to new_user_profile_path(@user)
  end

  private

  def params_user
    @user = current_user
  end

  def preprofile_params
    params.require(:preprofile).permit(:address, :kids, :mother_first_name, :father_first_name, :user, :phone, :photo)
  end
end
