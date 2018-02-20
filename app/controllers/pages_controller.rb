# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home update home_parent why]

  def home
    if current_user
      redirect_to new_user_profile_path(current_user) if current_user.profile.step < 6
    end
    if cookie
      @slides = t('.slides')
      @slide_split = t('.slide_with_split')
      @slide_plan = t('.slide_plan')
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
    render plain: 'one more step'
  end

  def why
    @guest = guest_user
    @slides = t('.slides')
    @slides_manifeste = t('.manifeste')
  end

  private

  def params_guest
    params.require(:guest).permit(:email)
  end
end
