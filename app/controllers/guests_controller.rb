class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show]

  def create
    @guest = Guest.new(params_guest)
    if @guest.save!
      UserMailer.welcome(@guest).deliver_now
      render :welcome
    end
  end

  def welcome
   @guest = Guest.find_by_email(params[:guest][:email])
  end


  private

  def params_guest
    params.require(:guest).permit(:email)
  end
end
