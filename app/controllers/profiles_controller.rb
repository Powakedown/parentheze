class ProfilesController < ApplicationController
  def new
    @user = current_user
    @profile = Profile.new
    @current_step = @profile.step || 2
    @signup_length = 5
  end

  def create

  end

  def show

  end

  def update

  end
end
