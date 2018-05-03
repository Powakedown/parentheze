# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home why]

  def home
    if current_user
      if current_user.profile.validated?
        redirect_to "/profiles"
      elsif current_user.profile.step < 6
        redirect_to new_user_profile_path(current_user)
      end
    end
    if cookie
      @slide_top = t('.slide_home_top')
      @slide_split = t('.slide_with_split')
      @slide_plan = t('.slide_plan')
      @slide_contact = t('.slide_contact')
      @guest = guest_user
      @guest.visit += 1
      @guest.save
    else
      redirect_to new_guest_path
    end
  end

  def why
    @guest = guest_user
    @slides = t('.slides')
    @slides_manifeste = t('.manifeste')
  end

end
