class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :cookie_presence

  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= Guest.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def create_guest_user
    u = Guest.new(:name => "guest", :email => "email@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

  def cookie_presence
    @cookie = cookies[:parentheze_guest].present?
  end

end
