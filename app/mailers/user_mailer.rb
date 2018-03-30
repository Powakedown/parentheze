# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'parentgenial@parentheze.com'
  before_action host_url

  def host_url
    @url = Rails.application.config.action_mailer.default_url_options
    @admin_mail = 'parentgenial@parentheze.com'
  end

  def welcome(guest_as_hash)
    mail(to: guest_as_hash[:mail],
         subject: 'Inscription à la béta de parentheze',
         track_opens: 'true')
  end

  def self_notification
    mail(to: @admin_mail,
         subject: 'Nouveau Guest sur Parentheze',
         track_opens: 'true')
  end

  def new_registration(user_as_hash)
    mail(to: user_as_hash[:mail],
         subject: 'Inscription à la béta de parentheze',
         track_opens: 'true')
  end

  def contact_form(mail_content)
    @name = mail_content[:name]
    @mail = mail_content[:mail]
    @comment = mail_content[:comment]
    mail(to: @admin_mail,
         subject: 'Nouveau message depuis Parentheze',
         track_opens: 'true')
  end

  def notification(mail_content)
    @subject = mail_content[:subject]
    @user_address = mail_content[:user_address]
    @user_names = mail_content[:user_names]
    mail(to: 'parentgenial@parentheze.com',
         subject: mail_content[:subject],
         track_opens: 'true')
  end

  def add_friend(mail_content)
    @friend_mail = mail_content[:friend_mail]
    @host_mail = mail_content[:host_mail]
    @host_photo = mail_content[:host_photo]
    @host_names = mail_content[:host_names]
    @host_is_couple = mail_content[:host_is_couple]
    mail(to: @friend_mail,
         subject: @host_names + " vous invite à les rejoindre sur Parentheze",
         track_opens: 'true')
  end

  def validation(user_as_hash)
    mail(to: user_as_hash[:mail],
         subject: 'Votre profil est validé!',
         track_opens: 'true')
  end

  def request_update(user_as_hash)
    @profile = user_as_hash[:profile]
    @params = user_as_hash[:params]
    mail(to: user_as_hash[:mail],
         subject: 'Votre profil sur Parentheze',
         track_opens: 'true')
  end
end
