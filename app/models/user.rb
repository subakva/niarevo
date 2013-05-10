# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string(255)      not null
#  email               :string(255)      not null
#  crypted_password    :string(255)      not null
#  password_salt       :string(255)      not null
#  persistence_token   :string(255)      not null
#  single_access_token :string(255)      not null
#  perishable_token    :string(255)      not null
#  login_count         :integer          default(0), not null
#  failed_login_count  :integer          default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  active              :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_created_at           (created_at)
#  index_users_on_email                (email) UNIQUE
#  index_users_on_perishable_token     (perishable_token) UNIQUE
#  index_users_on_persistence_token    (persistence_token) UNIQUE
#  index_users_on_single_access_token  (single_access_token) UNIQUE
#  index_users_on_username             (username) UNIQUE
#

class User < ActiveRecord::Base
  include Gravtastic
  is_gravtastic!
  acts_as_authentic

  has_many :dreams
  has_many :invites
  validates_exclusion_of :username, in: ['admin', 'user', 'anonymous']

  scope :active, where(active: true)

  def activate!
    unless self.active?
      self.update_attribute(:active, true)
      Notifier.activation_succeeded(self).deliver
    end
  end

  def deactivate!
    update_attribute(:active, false)
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.activation_instructions(self).deliver
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end

  class << self
    def find_by_username_or_email(params)
      user = nil
      if params[:username]
        user = User.where(username: params[:username]).first
      end
      if params[:email]
        user ||= User.where(email: params[:email]).first
      end
      if params[:username_or_email]
        user ||= User.where(username: params[:username_or_email]).first
        user ||= User.where(email: params[:username_or_email]).first
      end
      user
    end
  end
end
