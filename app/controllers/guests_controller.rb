class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :index, :update, :new, :welcome]
  before_action :find_guest, only: [:update, :welcome]
  before_action :init_form, only: [:update, :new]

  def index
    @guests = Guest.not_tester
    @guestcount = @guests.count
    @visits = @guests.sum(:visit)
    @parents = @guests.parenting.count
    @questions = t('survey.questions').first(4)
    @form_completed_p = @guests.where.not(get_out: nil).count * 100/(@guestcount)
    @guests_visitors_p =  @guests.visitors.count * 100/(@guestcount)
    @guest_steps = []
    0.upto(6) {|x| @guest_steps << @guests.visitors.where(step: (x..6)).count * 100 / (@guests.visitors.count)}
  end

  def new
    if cookie
      if cookies[:parentheze_mail] != "max@max.com"
        redirect_to root_path
      else
        @current_question = session[:form_step] = 1
      end
    else
      @guest = Guest.create!
      session[:guest_user_id] = @guest.id
      @current_question = session[:form_step] = 1
      cookies[:parentheze_guest] = {
        value: @guest.id,
        expires: 1.year.from_now
      }
    end
  end

  def update
    @guest.update(guest_params)
    @current_question = session[:form_step] = params[:guest][:form_step]
    if @guest.email != "email@example.com" && @guest.valid? && @guest.email != "max@max.com"
      cookies[:parentheze_mail] = {
        value: @guest.email,
        expires: 1.year.from_now
      }
      redirect_to :welcome
    elsif params[:guest][:email]
      flash[:alert] =  "Veuillez entrez un email valide"
      redirect_to "/home#inscription-beta"
    else
      render :new
    end
  end

  def welcome
    begin
      UserMailer.welcome(@guest).deliver_now
      UserMailer.self_notification(@guest).deliver_now
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
    params.require(:guest).permit(:parent, :kid_age, :jalous, :get_out, :old_kid, :email, :name, :step, :bordelais)
  end

  def init_form
    @questions_number = t('survey.questions').length
    @breadcrumb_length = 4
  end
end
