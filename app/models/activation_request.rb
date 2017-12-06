# frozen_string_literal: true

class ActivationRequest
  include ActiveModel::Model

  validates :username_or_email, presence: true
  validates :user, presence: { message: "Sorry, we couldn't find that account." }
  validate :user_is_unactivated

  attr_accessor :username_or_email

  def create
    return false unless valid?
    user.deliver_activation_instructions!
  end

  def user
    @user ||= User.with_username_or_email(username_or_email).first
  end

  def active_user?
    user && user.active?
  end

  def user_is_unactivated
    errors.add(:base, 'That account is already active.') if active_user?
  end
end
