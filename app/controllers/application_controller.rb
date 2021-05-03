# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :exception

  helper_method :current_user_session, :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)

    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    return if current_user

    store_location
    flash[:notice] = "You must be logged in to access this page"
    redirect_to new_user_session_url
  end

  def redirect_to_account_if_logged_in
    return unless current_user

    flash[:notice] = 'You are already logged in.'
    redirect_to account_url
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
