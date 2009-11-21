class UserSessionsController < ApplicationController

  before_filter :redirect_to_account_if_logged_in, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Welcome back!"
      redirect_back_or_default account_url
    else
      flash[:error] = "Please enter a correct username and password. Note that both fields are case-sensitive."
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
