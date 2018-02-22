class UsersController < ApplicationController

  def show
  end

  def index
    if current_user.admin
      @profiles = Profile.where(validation: 0)
    else
      redirect_to root_path
    end
  end

  def edit
  end
end
