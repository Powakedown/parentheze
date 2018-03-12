# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home update home_parent why contact]

  def home
    if current_user && current_user.profile.validated?
      redirect_to "/profiles"
    elsif current_user && current_user.profile.step < 6
      redirect_to new_user_profile_path(current_user)
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
    @valid_email = email_valid(@message[:email])
    @valid_comment = comment_valid(@message[:comment])
    @human = params[:iamhuman].present?

    if @valid_email && @valid_comment && @human
      session[:contact_email] = session[:contact_name] = session[:contact_comment] = nil
      flash[:success] = t('.notice')
      UserMailer.contact_form(@message[:name], @message[:email], @message[:comment]).deliver_later
      redirect_to root_path
    else
      session[:contact_email] = @message[:email]
      session[:contact_name] = @message[:name]
      session[:contact_comment] = @message[:comment]
      flash[:warning1] = t('.be_human') unless @human
      flash[:warning2] = t('.invalid_email') unless @valid_email
      flash[:warning3] = t('.blank_email') unless @email_presence
      flash[:warning4] = t('.invalid_comment') unless @valid_comment
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
