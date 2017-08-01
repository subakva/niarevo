# frozen_string_literal: true

class UserSession < Authlogic::Session::Base
  def account_inactive?
    errors.full_messages.include?('Your account is not active')
  end
end
