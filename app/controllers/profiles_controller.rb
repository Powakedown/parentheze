# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :user_is_current_user, only: %i[create new edit update previous]
  before_action :params_profile, only: %i[validate request_update]

  def new
    @profile = @user.profile || Profile.new(user: @user, step: 1, validation: 0)
    @profile.step = 1 if @profile.step < 1
    @profile.save!
    @step = @profile.step
    redirect_to edit_user_profile_path(@user, @profile)
  end

  def show
  end

  def edit
    @profile = @user.profile
    #If user come back on edit after receiving request update mail
    if @profile.validation == 2
      @profile.validation = 0
      @error_label = true
      @profile.save
      flash[:warning] = t('.flash-after-request')
    end
    @profile.save!
    @step = @profile.step
  end

  def update
    @profile = @user.profile
    @profile.step += 1
    if @profile.step5?
      add_wishes(@user, @profile)
    else
      if @profile.update(profile_params)
        redirect_to edit_user_profile_path
        inscription_done(@user) if @profile.step6?
      else
        notice = ''
        @profile.errors.messages.each do |key, value|
          notice << value.first << '. <br/>'
        end
        redirect_to edit_user_profile_path, alert: notice
      end
    end
  end

  def add_wishes(user, profile)
    user.user_wishes.destroy_all
    wishes = Wish.all.to_a
    wishes.each_with_index do |wish, index|
      UserWish.create(user: user, wish: wish) if profile_params[("need"<<index.to_s).to_sym] == "true"
    end
    profile.save
    redirect_to edit_user_profile_path
  end

  def inscription_done(user)
    UserMailer.new_registration(user).deliver_now
    UserMailer.new_registration_notification.deliver_now
  end

  def validate
    @profile.validation = 1
    if @profile.save
      flash[:notice] = t('.notice')
      redirect_to admin_validations_path
      UserMailer.validation(@profile.user).deliver_now
    else
      flash[:warning] = t('.alert')
      redirect_to admin_validations_path
    end
  end

  def request_update
    @updates_requested = request_update_params
    @profile_for_mail = @profile.as_json

    UserMailer.request_update(@profile.user, @profile_for_mail, @updates_requested).deliver_now
    flash[:notice] = t('.notice')

    if request_update_params[:parent1].present?
      @profile.step = 2
      @profile.parent1 = nil
    elsif request_update_params[:kids].present?
      @profile.step = 2
      @profile.kids = nil
    elsif request_update_params[:parent2].present?
      @profile.step = 2
      @profile.parent2 = nil
    elsif request_update_params[:address].present?
      @profile.step = 3
      @profile.address = nil
    elsif request_update_params[:phone].present?
      @profile.step = 4
      @profile.phone = nil
    else request_update_params[:photo].present?
      @profile.step = 5
      @profile.photo = nil
    end

    if @profile.save
      redirect_to admin_validations_path
    else
      flash[:warning] = "PROBLEM"
      redirect_to admin_validations_path
    end
  end

  def previous
    @profile = @user.profile
    @profile.step -= 1
    @profile.save!
    redirect_to edit_user_profile_path(@user)
  end

  private

  def user_is_current_user
    @user = current_user
  end

  def params_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:address, :kids, :mother_first_name, :father_first_name, :phone, :confidence, :need0, :need1, :need2, :need3, :photo, :lat, :lng )
  end

  def request_update_params
    params.permit(:address, :kids, :parent1, :parent2, :phone, :photo)
  end
end
