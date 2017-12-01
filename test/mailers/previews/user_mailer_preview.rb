class UserMailerPreview < ActionMailer::Preview
  def welcome
    @user = Guest.first
    UserMailer.welcome(@user)
  end

  def self_notification
    @user = Guest.first
    UserMailer.self_notification(@user)
  end

end
