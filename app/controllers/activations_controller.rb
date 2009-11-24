class ActivationsController < ApplicationController
  before_filter :redirect_to_account_if_logged_in
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def index
    render :action => :new
  end

  def new
  end

  def create
    @user = User.find_by_username_or_password(params)
    if @user && @user.active?
      flash[:notice] = "Your account is already active. Maybe you need to reset your password?"
      redirect_to new_password_reset_url(:username => @user.username)
    elsif @user
      @user.deliver_activation_instructions!
      flash.now[:notice] = "An activation key was sent by email. Follow the link in the email to activate your account."
      render :action => :new
    else
      flash.now[:error] = "Sorry, we couldn't find that account. Check for typos and try again."
      render :action => :new
    end
  end

  def edit
    update
  end

  def update
    @user.activate!
    flash[:notice] = "Your account is now activated! Please sign in."
    redirect_to new_user_session_url
  end

  protected
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Sorry, we couldn't find that account. " +
        "If you are having issues, try copying and pasting the URL " +
        "from your email into your browser or requesting another activation key."
      redirect_to new_user_session_url
    end
  end
  
end
