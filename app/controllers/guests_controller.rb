# frozen_string_literal: true

class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create index update new welcome]
  before_action :find_guest, only: %i[update welcome]
  before_action :init_form, only: %i[update new]

  def index
    redirect_to root_path unless tester
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
    # @guest_steps = []
    # 0.upto(4) { |x| @guest_steps + percentage(@guests.visitors.where(step: (x..6)), @visits) }
  end

  def new
    redirect_to root_path if cookie && !tester
    @guest = guest_user
    session[:form_step] ||= "1"
    set_question
  end

  def update
    @guest.update(guest_params)
    @current_question = session[:form_step] = params[:guest][:form_step] ||= "9"
    set_question
    if @guest.email != 'email@example.com' && @guest.valid? && !params[:guest][:email].nil?
      welcome_mail(@guest)
      flash[:notice] = t('.emailsent')
      redirect_to root_path
    elsif params[:guest][:email]
      flash[:warning] = t('.email_valid')
      redirect_to root_path
    else
      render :new
    end
  end

  def welcome_mail(user)
    UserMailer.welcome({mail: user.mail}).deliver_later
    UserMailer.self_notification.deliver_later
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
    @breadcrumb_length = 5
  end

  def set_question
    @question = @questions[('question'+session[:form_step]).to_sym]
  end
end
