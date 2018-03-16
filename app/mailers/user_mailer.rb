# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'parentgenial@parentheze.com'

  def welcome(guest)
    @user = guest
    @url  = 'https://www.parentheze.com'
    mail(to: @user.email,
         from: 'parentgenial@parentheze.com',
         subject: 'Inscription à la béta de parentheze',
         track_opens: 'true')
  end

  def welcome_redirection(guest)
    @user = guest
  end

  def self_notification(guest)
    @user = guest
    mail(to: 'abriko@yahoo.fr',
         from: 'parentgenial@parentheze.com',
         subject: 'Nouveau Guest sur Parentheze',
         track_opens: 'true')
  end

  def new_registration(user)
    @user = user
    @url  = 'https://www.parentheze.com'
    mail(to: @user.email,
         from: 'parentgenial@parentheze.com',
         subject: 'Inscription à la béta de parentheze',
         track_opens: 'true')
  end

  def contact_form(user, email, comment)
    @name = user
    @email = email
    @comment = comment
    mail(to: 'abriko@yahoo.fr',
         from: 'parentgenial@parentheze.com',
         subject: 'Nouveau message depuis Parentheze',
         track_opens: 'true')
  end

  def notification(subject, user_email, user_address, user_names)
    @subject = subject
    @user_address = user_address
    @user_names = user_names
    mail(to: 'parentgenial@parentheze.com',
         from: user_email,
         subject: subject,
         track_opens: 'true')
  end

  def add_friend(friend_mail, host_mail, host_photo, host_names, host_is_couple)
    @friend_mail = friend_mail
    @host_mail = host_mail
    @host_photo = host_photo
    @host_names = host_names
    @host_is_couple = host_is_couple
    mail(to: @friend_mail,
         from: @host_mail,
         subject: @host_names + " vous invite à les rejoindre sur Parentheze",
         track_opens: 'true')
  end

  def validation(user)
    @user = user
    @url  = 'https://www.parentheze.com'
    mail(to: @user.email,
         from: 'parentgenial@parentheze.com',
         subject: 'Votre profil est validé!',
         track_opens: 'true')
  end

  def request_update(user, profile, params)
    @user = user
    @profile = profile
    @url  = 'https://www.parentheze.com'
    @params = params
    mail(to: @user,
         from: 'parentgenial@parentheze.com',
         subject: 'Votre profil sur Parentheze',
         track_opens: 'true')
  end
end
