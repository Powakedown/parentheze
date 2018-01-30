class ProfilesController < ApplicationController
  before_action :params_user, only: %i[create new update]

  def new
    @profile = Profile.new
    @preprofile = @user.preprofile || Preprofile.create(user: @user, step: 2)
    @current_step = @preprofile.step
  end

  def create

  end

  def show

  end

  def update

  end

  private

  def params_user
    @user = current_user
  end

  def preprofile_params
    params.require(:preprofile).permit(:address, :kids, :mother_first_name, :father_first_name, :user, :phone)
  end
end
