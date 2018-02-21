# frozen_string_literal: true

class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create index update new welcome]
  before_action :find_guest, only: %i[update welcome]
  before_action :init_form, only: %i[update new]

  def index
    if tester
      @guests = Guest.not_tester
      @guestcount = @guests.count
      @parentcount = @guests.parenting.count
      @visits = @guests.visitors.parenting.count
      @visitors_p = percentage(@visits, @guestcount)
      @parents = percentage(@parentcount, @guestcount)
      @average_visits = average(@guests, :visit)
      @questions = t('.questions').first(5)
      @form_completed_p = completion(@guests, :get_out)
      @target1 = percentage(@guests.target1, @parentcount)
      @target2 = percentage(@guests.target2, @parentcount)
      @guest_steps = []
      0.upto(4) { |x| @guest_steps << percentage(@guests.visitors.where(step: (x..6)), @visits) }
    else
      redirect_to root_path
    end
  end

  def new
    if cookie && !tester
      redirect_to root_path
    else
      @guest = guest_user
      @current_question = session[:form_step] = 1
    end
  end

  def update
    @guest.update(guest_params)
    @current_question = session[:form_step] = params[:guest][:form_step]
    if @guest.email != 'email@example.com' && @guest.valid? && !params[:guest][:email].nil?
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
    @guest = guest_user
  end

  def guest_params
    params.require(:guest).permit(:parent, :kid_age, :jalous, :get_out, :old_kid, :email, :name, :step, :bordelais, :host)
  end

  def init_form
    @questions = t('.questions')
    @questions_number = t('.questions').length
    @breadcrumb_length = 5
  end
end
