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

  def self_notification(guest)
    @user = guest
    mail(to: "abriko@yahoo.fr", from: "parentgenial@parentheze.com", subject: 'Nouveau Guest sur Parentheze', :track_opens => 'true')
  end

end
