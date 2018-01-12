# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home update home_parent why]

  def home
    if cookie
      @slides = t('home.slides')
      @slide_shows = t('home.slide_with_split')
      @slide_plan = t('home.slide_plan')
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
    @slides = t('why.slides')
    @slides_manifeste = t('why.manifeste')
  end

  private

  def params_guest
    params.require(:guest).permit(:email)
  end
end
