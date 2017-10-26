class UserMailer < ApplicationMailer
  default from: 'noreply@parentheze.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://www.parentheze.com'
    mail(to: @user.email, subject: 'Inscription pour la béta de parentheze')
  end

end
