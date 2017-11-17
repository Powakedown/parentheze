class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :update, :new]
  before_action :find_guest, only: [:update, :show]

  def show
  end

  def new
    @questions_number = t('survey.questions').length
    @breadcrumb_length = 4
    @guest = Guest.create(name: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    session[:guest_user_id] = @guest.id
  end

  def create
    # at the end of the survey
  end

  def update
    guest = Guest.update(guest_params)
  end

  def welcome
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

  private

  def find_guest
    @guest = Guest.find(session[:guest_user_id])
  end

  def guest_params
    params.require(:guest).permit(:parent, :kid_age, :jalous, :get_out, :old_kid, :email, :name)
  end
end
