# frozen_string_literal: true

class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create index update new welcome]
  before_action :find_guest, only: %i[update welcome]
  before_action :init_form, only: %i[update new]

  def index
    @guests = Guest.not_tester
    @guestcount = @guests.count
    @visits = @guests.visitors.count
    @visitors_p = @visits * 100 / (@guestcount)
    @parents = @guests.count(:parent)
    @average_visits = average(@guests, :visit)
    @questions = t('survey.questions').first(5)
    @form_completed_p = completion(@guests, :get_out)
    @guest_steps = []
    0.upto(4) { |x| @guest_steps << @guests.visitors.where(step: (x..6)).count * 100 / (@visits) }
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
      flash[:alert] = t('errors.email_valid')
      redirect_to '/home#inscription-beta'
    else
      render :new
    end
  end

  def welcome
    UserMailer.welcome(@guest).deliver_now
    UserMailer.self_notification(@guest).deliver_now
    flash[:notice] = t('inscription.redirection.emailsent')
    render :welcome
  rescue => e
    @error = e.message
    redirect_to '/home#inscription-beta'
    flash[:alert] = @error.to_s
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
