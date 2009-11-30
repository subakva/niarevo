# == Schema Information
#
# Table name: invites
#
#  id             :integer(4)      not null, primary key
#  message        :string(255)
#  recipient_name :string(32)      not null
#  email          :string(100)     not null
#  user_id        :integer(4)      not null
#  sent_at        :datetime
#  created_at     :datetime
#  updated_at     :datetime
#

class Invite < ActiveRecord::Base
  belongs_to :user

  named_scope :sent_after, lambda { |min_date| { :conditions => ['sent_at >= ?', min_date] } }

  attr_accessible :email

  validates_presence_of :recipient_name
  validates_length_of :recipient_name, :within => 0..255, :allow_blank => true
  validates_length_of :message, :within => 0..255, :allow_blank => true
  validates_presence_of :user_id
  validates_length_of :email, validates_length_of_email_field_options
  validates_format_of :email, validates_format_of_email_field_options
  validates_uniqueness_of :email, :scope => :user_id, :message => 'has already been invited.'

  validate :user_does_not_exist
  
  def deliver_invitation!
    invited_recently = Invite.email_eq(self.email).sent_after(7.days.ago).exists?
    unless invited_recently
      Notifier.deliver_invitation(self)
      self.update_attribute(:sent_at, Time.now.utc)
    end
  end
  
  protected
  def user_does_not_exist
    if self.email && User.email_eq(self.email).exists?
      self.errors.add_to_base('An account already exists for that email.')
    end
  end
end
