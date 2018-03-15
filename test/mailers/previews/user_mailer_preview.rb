class UserMailerPreview < ActionMailer::Preview
  def welcome
    @user = Guest.first
    UserMailer.welcome(@user)
  end

  def self_notification
    @user = Guest.first
    UserMailer.self_notification
  end

  def new_registration
    @user = User.last
    UserMailer.new_registration(@user)
  end

  def new_registration_notification
    UserMailer.new_registration_notification
  end

  def validation
    @user = User.last
    UserMailer.validation(@user)
  end

  def invitation
    @user = User.last
    UserMailer.invitation(@user)
  end

  def request_update
    @user = User.last
    UserMailer.request_update(@user, params)
  end
end
