class GuestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :survey, :update, :new]


  def show
   @guest = Guest.find(session[:guest_user_id])
  end

  def new
    @questions_number = t('survey.questions').length
    @breadcrumb_length = 4
    @guest = User.new
  end

  def create
    # at the end of the survey
    guest = User.create(guest_params)
    guest.update(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    guest.save!(:validate => false)
    session[:guest_user_id] = guest.id
  end

  def update
    begin
      @guest.save!
      UserMailer.welcome(@guest).deliver_now
      flash[:notice] =  t('inscription.redirection.emailsent')
      render :welcome
    rescue => e
      @error = e.message
      redirect_to "/home#slide_calltoaction"
      flash[:alert] =  "#{@error}"
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:parent, :kid_age, :jalous, :get_out, :old:_kid, :email, :name)
  end
end
