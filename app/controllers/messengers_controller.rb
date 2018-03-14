class MessengersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[contact mini_contact]

  def contact
    @message = params_message
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

  def mini_contact
    @message = params_message
    @valid_comment = comment_valid(@message[:comment])
    @user = current_user
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

  def params_message
    params.require(:message).permit(:email, :name, :comment, :iamhuman)
  end

end
