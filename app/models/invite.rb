# frozen_string_literal: true

# == Schema Information
#
# Table name: invites
#
#  id             :integer          not null, primary key
#  message        :string(255)
#  recipient_name :string(64)       not null
#  email          :string(255)      not null
#  user_id        :integer          not null
#  sent_at        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_invites_on_email              (email)
#  index_invites_on_email_and_user_id  (email,user_id) UNIQUE
#  index_invites_on_sent_at            (sent_at)
#  index_invites_on_user_id            (user_id)
#
# Foreign Keys
#
#  invites_user_id_fk  (user_id => users.id) ON DELETE => cascade
#

class Invite < ApplicationRecord
  belongs_to :user

  scope :sent_after, (lambda do |min_date|
    where('sent_at >= ?', min_date)
  end)

  validates :recipient_name, presence: true
  validates :recipient_name, length: {
    within: 0..255, allow_blank: true
  }
  validates :message, length: {
    within: 0..255, allow_blank: true
  }
  validates :user_id, presence: true
  validates :email, length: validates_length_of_email_field_options
  validates :email, format: validates_format_of_email_field_options
  validates :email, uniqueness: {
    scope: :user_id,
    message: 'has already been invited.'
  }

  validate :user_does_not_exist

  def deliver_invitation!
    invited_recently = Invite.where(email: email).sent_after(7.days.ago).exists?
    return if invited_recently

    Notifier.invitation(self).deliver
    update_attributes(sent_at: Time.zone.now)
  end

  protected

  def user_does_not_exist
    return unless email && User.where(email: email).exists?

    errors.add(:base, 'An account already exists for that email.')
  end
end
