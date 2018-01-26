class ProfilesController < ApplicationController
  def inscription
    @user = current_user
    @current_step = 2
    @signup_length = 5
  end

  def show

  end

  def update
    raise
    @current_step += 1
  end
end
