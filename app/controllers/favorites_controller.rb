# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :params_profile, only: %i(create destroy)

  def create
    @favorite = Favorite.new(profile: @current_profile, favorite: @profile.id)
    if @favorite.save!
      flash[:notice] = t('.notice')
    end
  end

  def destroy
    @favorite = Favorite.where(profile: @current_profile, favorite: @profile.id).first
    if @favorite.destroy
      flash[:notice] = t('.notice')
    end
  end

  private

  def params_profile
    @profile = Profile.find(params[:profile_id])
    @user = @profile.user
    @current_profile = current_user.profile
  end
end
