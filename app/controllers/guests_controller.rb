class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :index, :update, :new, :welcome]
  before_action :find_guest, only: [:update, :welcome]

  def index
    @guests = Guest.all
    @guestcount = @guests.count
    @visits = @guests.sum(:visit)
    @parents = @guests.where(parent: 1).count
    @questions = t('survey.questions').first(4)
    @form_end = @guests.where.not(get_out: nil).count * 100/(@guestcount)
    @guests_on_landing = @guests.where.not(visit: 0).count * 100/(@guestcount)
  end

  def new
    @questions_number = t('survey.questions').length
    @breadcrumb_length = 4
    @guest = Guest.create(email: "email@example.com", visit: 0, step: 0)
    session[:guest_user_id] = @guest.id
    cookies[:parentheze_guest] = {
      value: @guest.id,
      expires: 1.year.from_now,
    }
  end

  def update
    @guest.update(guest_params)
    if @guest.email != "email@example.com"
      redirect_to :welcome
    elsif params[:guest][:email]
      flash[:alert] =  "Veuillez entrez votre email"
      redirect_to "/home#inscription-beta"
    end
  end

  def welcome
    begin
      UserMailer.welcome(@guest).deliver_now
      flash[:notice] =  t('inscription.redirection.emailsent')
      render :welcome
    rescue => e
      @error = e.message
      redirect_to "/home#inscription-beta"
      flash[:alert] = "#{@error}"
    end
  end

  private

  def find_guest
    @guest = Guest.find(session[:guest_user_id])
  end

  def guest_params
    params.require(:guest).permit(:parent, :kid_age, :jalous, :get_out, :old_kid, :email, :name, :step)
  end
end
