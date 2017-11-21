class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :index, :update, :new, :welcome]
  before_action :find_guest, only: [:update, :show, :welcome]

  def index
    @guests = Guest.all
    @guestcount = @guests.count
    @visits = @guests.sum(:visit)
    @parents = @guests.where(parent: 1).count
    @questions = t('survey.questions').first(4)
  end

  def new
    @questions_number = t('survey.questions').length
    @breadcrumb_length = 4
    @guest = Guest.create(name: "guest", email: "email@example.com", visit: 1)
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
    params.require(:guest).permit(:parent, :kid_age, :jalous, :get_out, :old_kid, :email, :name)
  end
end
