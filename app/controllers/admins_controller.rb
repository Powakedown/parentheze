class AdminsController < ApplicationController
  before_action :security_check, only: %i[validations password_check password_verification]

  def password_check
  end

  def password_verification
    if params[:query][:password] == "#{ENV['ADMIN_PASSWORD']}" && current_user.admin
      redirect_to admin_validations_path
    else
      flash[:alert] = t('.alert')
      redirect_to admin_path
    end
  end

  def validations
    @profiles = Profile.where(step: 6, validation: 0)
  end

  private

  def security_check
    unless current_user.admin == true
      redirect_to root_path
      flash[:alert] = t('.alert')
    end
  end
end
