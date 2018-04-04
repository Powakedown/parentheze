# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'parentgenial@parentheze.com'
  before_action :host_url

  def custom_mail(recipient, mail_content)
    @mail_content = mail_content
    mail(to: recipient,
         subject: mail_content[:subject],
         track_opens: 'true')
  end

  def host_url
    @url = Rails.application.config.action_mailer.default_url_options
    @admin_mail = 'parentgenial@parentheze.com'
  end

  def welcome(guest_as_hash)
    mail(to: guest_as_hash[:email],
         subject: 'Inscription à la béta de parentheze',
         track_opens: 'true')
  end

  def new_registration(user_as_hash)
    mail(to: user_as_hash[:email],
         subject: 'Inscription à la béta de parentheze',
         track_opens: 'true')
  end

  def notification(mail_content)
    @mail_content = mail_content
    mail(to: @admin_mail,
         subject: mail_content[:subject],
         track_opens: 'true')
  end

  def add_friend(friend_mail, host)
    @friend_mail = friend_mail
    @host_mail = host[:mail]
    @host_photo = host[:photo]
    @host_names = host[:name]
    @host_is_couple = host[:couple]
    mail(to: @friend_mail,
         subject: @host_names + " vous invite à les rejoindre sur Parentheze",
         track_opens: 'true')
  end

  def validation(user_as_hash)
    mail(to: user_as_hash[:email],
         subject: 'Votre profil est validé!',
         track_opens: 'true')
  end

  def request_update(mail, profile, updates)
    @profile = profile
    @params = updates
    mail(to: mail,
         subject: 'Votre profil sur Parentheze',
         track_opens: 'true')
  end
end
