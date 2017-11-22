class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :scroll]

  def home
    if cookies[:parentheze_guest] && cookies[:parentheze_guest] != ""
      @guest = guest_user
      @guest.visit.nil? ? @guest.visit = 1 : @guest.visit += 1
      @guest.save
    else
      redirect_to new_guest_path
    end
  end

  def scroll
    raise
  end
end
