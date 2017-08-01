# frozen_string_literal: true

class ActivationsController < ApplicationController
  before_action :redirect_to_account_if_logged_in
  before_action :load_user_using_perishable_token, only: [:edit, :update]

  def index
    @activation = ActivationRequest.new
    render :new
  end

  def new
    @activation = ActivationRequest.new
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    @activation = ActivationRequest.new(params[:activation_request].permit(:username_or_email))
    if @activation.create
      flash[:notice] = "An activation key was sent by email. " \
                       "Follow the link in the email to activate your account."
      redirect_to root_url
    elsif @activation.active_user?
      flash[:notice] = "Your account is already active. Maybe you need to reset your password?"
      redirect_to new_password_reset_url(username: @activation.user.try(:username))
    else
      flash[:warning] = "Sorry, we couldn't find that account. Check for typos and try again."
      redirect_back fallback_location: root_url
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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
    return @user if @user

    flash[:warning] = "Sorry, we couldn't find that account. " \
                      "If you are having issues, try copying and pasting the URL " \
                      "from your email into your browser or requesting another activation key."
    redirect_to new_user_session_url
  end
end
