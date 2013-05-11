class PasswordResetsController < ApplicationController

  before_filter :redirect_to_account_if_logged_in
  before_filter :load_user_using_perishable_token, only: [:edit, :update]

  def index
    render :action => :new
  end

  def new
    @reset = PasswordResetRequest.new
  end

  def create
    @reset = PasswordResetRequest.new(password_reset_params)
    if @reset.create
      flash[:notice] = "Instructions to reset your password have been emailed to you."
      redirect_to new_user_session_url
    elsif @reset.user && @reset.inactive_user?
      flash[:notice] = "Your account is not yet active. Do you need us to resend your activation key?"
      redirect_to new_activation_url(username: @reset.user.try(:username))
    else
      flash[:error] = "Sorry, we couldn't find that account. Check for typos and try again."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Your password has been updated."
      redirect_to account_url
    else
      render action: :edit
    end
  end

  protected

  def password_reset_params
    params.require(:password_reset_request).permit(:username_or_email)
  end

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Sorry, we couldn't find that account." +
        "If you are having issues try copying and pasting the URL " +
        "from your email into your browser or restarting the " +
        "reset password process."
      redirect_to new_user_session_url
    end
  end
end
