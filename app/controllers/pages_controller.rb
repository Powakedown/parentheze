class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :update]

  def home
    if @cookie
      @guest = guest_user
      @guest.visit += 1
      @guest.save
    else
      redirect_to new_guest_path
    end
  end

  def update
    @guest = guest_user
    @guest.step += 1
    @guest.save
    redirect_to root_path
  end
end
