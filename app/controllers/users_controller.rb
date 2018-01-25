class UsersController < ApplicationController
  def inscription
    @user = current_user
    @signup_length = 5
  end

  def show

  end

  def update

  end
end
