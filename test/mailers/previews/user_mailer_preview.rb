class UserMailerPreview < ActionMailer::Preview
  def welcome
    redirect_to root_path
    user = User.first
    # UserMailer.welcome(user)
    self_notification(user)
  end

  def self_notification(guest)
    @user = guest
  end

end
