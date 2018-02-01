class UsersController < ApplicationController

  def show
  end

  def index
  end

  def edit
    session[:email] = current_user.email
    sign_out current_user
    redirect_to new_user_registration_path
  end
end
