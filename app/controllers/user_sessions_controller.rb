class UserSessionsController < ApplicationController

  before_filter :redirect_to_account_if_logged_in, :only => [:new, :create, :show]
  before_filter :require_user, :only => [:destroy, :show]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    # TODO: Move this into UserSession
    session_saved = @user_session.save
    account_inactive = @user_session.errors && @user_session.errors.full_messages.include?('Your account is not active')
    if session_saved
      redirect_back_or_default account_url
    else
      if account_inactive
        flash[:error] = "Your account has not been activated yet."
      else
        flash[:error] = %{
          Please enter a correct username and password.
          Note that both fields are case-sensitive.
        }.squish
      end
      redirect_to new_user_session_path
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been logged out."
    redirect_back_or_default root_url
  end
end
