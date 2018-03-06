# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home update home_parent why contact]

  def home
    if current_user
      redirect_to new_user_profile_path(current_user) if current_user.profile.step < 6
    end
    if cookie
      @slide_top = t('.slide_home_top')
      @slide_split = t('.slide_with_split')
      @slide_plan = t('.slide_plan')
      @slide_contact = t('.slide_contact')
      @guest = guest_user
      @guest.visit += 1
      @guest.save
    else
      redirect_to new_guest_path
    end

  end

  def contact
    @message = params_message
    mail_regex = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/
    @valid_email = @message[:email] =~ mail_regex && @message[:email].present?
    @valid_comment = @message[:comment].present? && @message[:comment].length > 8
    @human = params[:iamhuman].present?

    if @valid_email && @valid_comment && @human

      session[:contact_email] = session[:contact_name] = session[:contact_comment] = nil
      flash[:notice] = t('.notice')
      UserMailer.contact_form(@message[:name], @message[:email], @message[:comment]).deliver_now
      redirect_to root_path

    else

      session[:contact_email] = @message[:email]
      session[:contact_name] = @message[:name]
      session[:contact_comment] = @message[:comment]
      flash[:alert] = t('.be_human') unless @human
      flash[:alert] = t('.invalid_email') unless @valid_email
      flash[:alert] = t('.blank_email') unless @email_presence
      flash[:alert] = t('.invalid_comment') unless @valid_comment
      redirect_to "/#slide4"

    end
  end

  def why
    @guest = guest_user
    @slides = t('.slides')
    @slides_manifeste = t('.manifeste')
  end

  private

  def params_message
    params.require(:message).permit(:email, :name, :comment, :iamhuman)
  end

  def params_guest
    params.require(:guest).permit(:email)
  end
end
