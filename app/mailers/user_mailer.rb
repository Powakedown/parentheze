# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'parentgenial@parentheze.com'

  def welcome(guest)
    @user = guest
    @url  = 'http://www.parentheze.com'
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
    @url  = 'http://www.parentheze.com'
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

  def new_registration_notification
    mail(to: 'parentgenial@parentheze.com',
         from: 'parentgenial@parentheze.com',
         subject: 'Nouvel Inscription sur parentheze',
         track_opens: 'true')
  end

  def validation(user)
    @user = user
    @url  = 'http://www.parentheze.com'
    mail(to: @user.email,
         from: 'parentgenial@parentheze.com',
         subject: 'Votre profil est validé!',
         track_opens: 'true')
  end

  def request_update(user, profile, params)
    @user = user
    @profile = profile
    @url  = 'http://www.parentheze.com'
    @params = params
    mail(to: @user,
         from: 'parentgenial@parentheze.com',
         subject: 'Votre profil sur Parentheze',
         track_opens: 'true')
  end
end
