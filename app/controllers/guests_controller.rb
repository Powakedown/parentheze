class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @guest = Guest.new(params_guest)
    if @guest.save!
      UserMailer.welcome(@guest).deliver_now
      flash.now[:alert] = t('flash.guest.new')
    end

  end

  private

  def params_guest
    params.require(:guest).permit(:email)
  end
end
