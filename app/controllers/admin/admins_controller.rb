module Admin
  class AdminsController < ApplicationController
    before_action :security_check, only: %i[validations password_check password_verification mailer letters requested]

    def destroy_profile
      @profile = Profile.find(params[:format])
      @profile.destroy
      redirect_to admin_validations_path
    end

    def custom_mailer
      @session = session[:custom_mail] || {}
      @recipient = ['1 - parentgenial@parentheze.com', '2 - Guest inscrits', '3 - Profils validés', '4 - Profils non complets']
    end

    def password_check; end

    def password_verification
      if params[:query][:password] == "#{ENV['ADMIN_PASSWORD']}" && current_user.admin?
        redirect_to admin_validations_path
      else
        flash[:warning] = t('.alert')
        redirect_to admin_path
      end
    end

    def requested
      @profiles = Profile.where(validation: 2)
    end

    def validations
      @profiles = Profile.to_validate
    end

    private
  end
end
