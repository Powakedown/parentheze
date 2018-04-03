module Admin
  class AdminsController < ApplicationController
    before_action :security_check, only: %i[validations password_check password_verification]

    def destroy_profile
      @profile = Profile.find(params[:format])
      @profile.destroy
      redirect_to admin_validations_path
    end

    def mailer; end

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

    def security_check
      return if current_user.admin?
      redirect_to root_path
      flash[:warning] = t('.alert')
    end
  end
end
