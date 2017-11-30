class UserMailer < ApplicationMailer
  default from: 'noreply@parentheze.com'

  def welcome(guest)
    @user = guest
    @url  = 'http://www.parentheze.com'
    mail(to: @user.email, from: "noreply@parentheze.com", subject: 'Inscription à la béta de parentheze', :track_opens => 'true')
    self_notification(guest)
  end

  def welcome_redirection(guest)
    @user = guest
  end

  def self_notification
    mail(to: "abriko@yahoo.fr", from: "noreply@parentheze.com", subject: 'Nouveau Guest sur Parentheze', :track_opens => 'true')
  end

end
