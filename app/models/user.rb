# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  username            :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  active              :boolean(1)      not null
#

class User < ActiveRecord::Base
  is_gravtastic!
  acts_as_authentic

  attr_accessible :username, :email, :password, :password_confirmation

  has_many :dreams
  has_many :invites
  validates_exclusion_of :username, :in => ['admin', 'user', 'anonymous']

  def activate!
    unless self.active?
      self.update_attribute(:active, true)
      Notifier.deliver_activation_succeeded(self)
    end
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  class << self
    def find_by_username_or_password(params)
      user = nil
      if params[:username]
        user = User.find_by_username(params[:username])
      end
      if params[:email]
        user ||= User.find_by_email(params[:email])
      end
      if params[:username_or_email]
        user ||= User.find_by_username(params[:username_or_email])
        user ||= User.find_by_email(params[:username_or_email])
      end
      user
    end
  end
end
