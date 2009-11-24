class UserSessionsController < ApplicationController

  before_filter :redirect_to_account_if_logged_in, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    session_saved = @user_session.save
    account_inactive = @user_session.errors && @user_session.errors.full_messages.include?('Your account is not active')
    if session_saved
      redirect_back_or_default account_url
    else
      if account_inactive
        flash.now[:error] = "Your account has not been activated yet."
      else
        flash.now[:error] = "Please enter a correct username and password. Note that both fields are case-sensitive."
      end
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been logged out."
    redirect_back_or_default new_user_session_url
  end
end
