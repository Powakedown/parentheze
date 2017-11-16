class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :survey]

  def create
    @guest = Guest.new(params_guest)
    begin
      @guest.save!
      UserMailer.welcome(@guest).deliver_now
      flash[:notice] =  t('inscription.redirection.emailsent')
      render :welcome
    rescue => e
      @error = e.message
      redirect_to "/home#slide_calltoaction"
      flash[:alert] =  "#{@error}"
    end
  end

  def welcome
   @guest = Guest.find_by_email(params[:guest][:email])
  end

  def survey
    @questions_number = t('survey.questions').length
    @breadcrumb_length = 4
  end


  private

  def params_guest
    params.require(:guest).permit(:email)
  end
end
