class UserMailer < ApplicationMailer
  default from: 'parentgenial@parentheze.com'

  def welcome(guest)
    @user = guest
    @url  = 'http://www.parentheze.com'
    mail(to: @user.email, from: "parentgenial@parentheze.com", subject: 'Inscription à la béta de parentheze', :track_opens => 'true')
  end

  def welcome_redirection(guest)
    @user = guest
  end
end
