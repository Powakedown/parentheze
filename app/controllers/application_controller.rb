# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :cookie
  before_action :session_ways?
  add_flash_types :success, :warning

  def average(collection, column)
    collection.average(column).to_digits.to_f.round(2)
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.validation == 1
      "/profiles"
    else
      new_user_profile_path(current_user)
    end
  end

  def create_guest_user
    u = Guest.new(name: 'guest', email: 'email@example.com')
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    cookies[:parentheze_guest] = {
      value: u.id,
      expires: 1.year.from_now
    }
    u
  end

  def completion(collection, column)
    collection.count(column) * 100 / collection.count
  end

  def comment_valid(comment)
    comment.present? && comment.length > 8
  end

  def cookie
    @cookie = cookies[:parentheze_guest].present?
  end

  def current_user?
    current_user.id == params[:user_id].to_i
  end

  def email_valid(email)
    mail_regex = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/
    email =~ mail_regex && email.length > 8
  end

  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= Guest.find(session[:guest_user_id] || cookies[:parentheze_guest] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    cookies[:parentheze_guest] = nil
    guest_user if with_retry
  end

  def mails(collection)
    collection.map { |x| x.email }
  end

  def percentage(serie, total)
    if serie.is_a? Integer
      serie * 100 / total
    else
      serie.count * 100 / total
    end
  end

  def session_ways?
    @session_ways = true
  end

  def security_check
    return if current_user.admin?
    redirect_to root_path
    flash[:warning] = t('.alert')
  end

  def tester
    guest_user.email == 'parentgenial@parentheze.com'
  end

end
