class MessengersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[contact mini_contact]
  before_action :message_from_params, only: %i[contact add_friend mini_contact ask_for_cards]
  before_action :who_is_user, only: %i[add_friend mini_contact ask_for_cards]

  def contact
    @valid_email = email_valid(@message[:email])
    @valid_comment = comment_valid(@message[:comment])
    @human = params[:iamhuman].present?

    if @valid_email && @valid_comment && @human
      session[:contact_email] = session[:contact_name] = session[:contact_comment] = nil
      flash[:success] = t('.notice')
      UserMailer.contact_form(@message[:name], @message[:email], @message[:comment]).deliver_later
      redirect_to root_path
    else
      session[:contact_email] = @message[:email]
      session[:contact_name] = @message[:name]
      session[:contact_comment] = @message[:comment]
      flash[:warning1] = t('.be_human') unless @human
      flash[:warning2] = t('.invalid_email') unless @valid_email
      flash[:warning3] = t('.blank_email') unless @email_presence
      flash[:warning4] = t('.invalid_comment') unless @valid_comment
      redirect_to "/#slide4"
    end
  end

  def add_friend
    @emails = @message[:comment].split(";").map(&:strip).select{|word| email_valid(word)}
    unless @emails.empty?
      @emails.each do |mail|
        UserMailer.add_friend(mail, @user.email, @user.photo.path.presence, @user.names, @user.profile.couple?).deliver_later
      end
      flash[:notice] = t('.notice')
      redirect_to add_friends_user_profile_path(@user, @user.profile)
    else
      session[:emails] = @message[:comment]
      flash[:warning] = t('.warning')
      redirect_to add_friends_user_profile_path(@user, @user.profile)
    end
  end

  def ask_for_cards
    @profile.card += 1
    @profile.name = @message[:comment]
    unless @message[:comment].present?
      flash[:warning] = t('.warning')
    elsif @profile.save!
      UserMailer.notification(t('.subject'), @user.email, @user.address, @user.names).deliver_now
      flash[:notice] = t('.notice')
      redirect_to profiles_path
    end
  end

  def mini_contact
    @valid_comment = comment_valid(@message[:comment])
    if @valid_comment
      flash[:success] = t('messengers.contact.notice')
      UserMailer.contact_form(@user.names, @user[:email], "mini_contact : " + @message[:comment]).deliver_later
      redirect_to profiles_path
    else
      flash[:warning1] = t('messengers.contact.invalid_comment')
      redirect_to "/profiles#over-footer"
    end
  end

  private

  def who_is_user
    @user = current_user
  end

  def message_from_params
    @message = params_message
  end

  def params_message
    params.require(:message).permit(:email, :name, :comment, :iamhuman)
  end

end
