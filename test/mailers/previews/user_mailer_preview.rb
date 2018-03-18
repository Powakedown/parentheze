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

  def notification
    UserMailer.notification
  end

  def validation
    @user = User.last
    UserMailer.validation(@user)
  end

  def add_friend
    @user = User.last
    UserMailer.add_friend("ami@ami.com", @user.email, @user.photo.path, @user.names, @user.profile.couple?)
  end

  def request_update
    @user = User.last
    UserMailer.request_update(@user, params)
  end
end
