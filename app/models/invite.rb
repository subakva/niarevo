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

class Invite < ActiveRecord::Base
  belongs_to :user

  scope :sent_after, ->(min_date) {
    where('sent_at >= ?', min_date)
  }

  validates_presence_of :recipient_name
  validates_length_of :recipient_name, within: 0..255, allow_blank: true
  validates_length_of :message, within: 0..255, allow_blank: true
  validates_presence_of :user_id
  validates_length_of :email, validates_length_of_email_field_options
  validates_format_of :email, validates_format_of_email_field_options
  validates_uniqueness_of :email, scope: :user_id, message: 'has already been invited.'

  validate :user_does_not_exist

  def deliver_invitation!
    invited_recently = Invite.where(email: self.email).sent_after(7.days.ago).exists?
    unless invited_recently
      Notifier.invitation(self).deliver
      self.update_attribute(:sent_at, Time.zone.now)
    end
  end

  protected
  def user_does_not_exist
    if self.email && User.where(email: self.email).exists?
      self.errors.add(:base, 'An account already exists for that email.')
    end
  end
end
