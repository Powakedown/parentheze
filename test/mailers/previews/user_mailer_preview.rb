class UserMailerPreview < ActionMailer::Preview
  def welcome
    redirect_to root_path
    user = User.first
    # UserMailer.welcome(user)
  end
end
