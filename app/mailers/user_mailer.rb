class UserMailer < ApplicationMailer
  default from: 'noreply@parentheze.com'

  def welcome(guest)
    @user = guest
    @url  = 'http://www.parentheze.com'
    mail(to: "maxime@parentheze.com", from: "maxime@parentheze.com", subject: 'Inscription à la béta de parentheze', :track_opens => 'true')
  end

end
