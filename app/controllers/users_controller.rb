class UsersController < ApplicationController

  def show
  end

  def index
    if current_user.admin
      @profiles = Profile.where.not(step: 10)
    else
      redirect_to root_path
    end
  end

  def edit
  end
end
