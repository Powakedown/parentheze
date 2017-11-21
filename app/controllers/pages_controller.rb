class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if cookies[:parentheze_guest] && cookies[:parentheze_guest] != ""
      @guest = guest_user
    else
      redirect_to new_guest_path
    end
  end
end
