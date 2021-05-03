# frozen_string_literal: true

class UserSessionsController < ApplicationController
  before_action :redirect_to_account_if_logged_in, only: [:new, :create, :show]
  before_action :require_user, only: [:destroy, :show]

  def new
    @user_session = UserSession.new
  end

  def show
    redirect_to account_path(current_user)
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @user_session = UserSession.new(user_session_params.to_h)
    # TODO: Move this into UserSession
    session_saved = @user_session.save
    account_inactive = @user_session.account_inactive?
    if account_inactive
      redirect_to new_user_session_path, flash: {
        error: "Your account has not been activated yet."
      }
    elsif session_saved
      redirect_back_or_default account_url
    else
      redirect_to new_user_session_path, flash: {
        error: %(
          Please enter a correct username and password.
          Note that both fields are case-sensitive.
        ).squish
      }
    end
  end
  # rubocop:enable Metrics/MethodLength

  def destroy
    current_user_session.destroy
    flash[:notice] = "You have been logged out."
    redirect_back_or_default root_url
  end

  protected

  def user_session_params
    params.require(:user_session).permit(:username, :password, :remember_me)
  end
end
