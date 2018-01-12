# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :cookie

  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= Guest.find(session[:guest_user_id] || cookies[:parentheze_guest] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    cookies[:parentheze_guest] = nil
    guest_user if with_retry
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

  def cookie
    @cookie = cookies[:parentheze_guest].present?
  end

  def average(collection, column)
    collection.average(column).to_digits.to_f.round(2)
  end

  def completion(collection, column)
    collection.count(column) * 100 / collection.count
  end

  def tester
    guest_user.email == 'parentgenial@parentheze.com'
  end

  def percentage(serie, total)
    if serie.is_a? Integer
      serie * 100 / total
    else
      serie.count * 100 / total
    end
  end
end
