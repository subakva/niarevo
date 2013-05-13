class UsersController < ApplicationController
  before_action :redirect_to_account_if_logged_in, :only => [:new, :create]
  before_action :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = "Thanks! A message has been sent to your email address with a link to activate your account."
      redirect_back_or_default new_user_session_url
    else
      render :action => :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
