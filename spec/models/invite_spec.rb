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

require File.dirname(__FILE__) + '/../spec_helper'

describe Invite do
  before(:each) do
    @invite = Factory.create(:invite)
  end

  should_belong_to :user

  should_have_scope :sent_after, :with => Time.local('2009'), :conditions => ['sent_at >= ?', Time.local('2009')]

  should_validate_presence_of :recipient_name
  should_validate_length_of :recipient_name, :within => 0..255, :allow_blank => true
  should_validate_length_of :message, :within => 0..255, :allow_blank => true
  should_validate_presence_of :user_id
  should_validate_length_of :email, :within => 6..100
  should_allow_values_for :email, 'a@b.com', 'a.b@b.com', 'a+b@b.co.uk'
  should_not_allow_values_for :email, '@b.com', 'a@b', 'ab'
  should_validate_uniqueness_of :email, :scope => :user_id, :message => 'has already been invited.'

  should_allow_mass_assignment_of :email
  
  it "should not create an invite for a current user" do
    @user = @invite.user
    invite = Invite.new(:email => @user.email)
    invite.should_not be_valid
    invite.should have(1).error_on(:base)
    invite.errors[:base].should include('An account already exists for that email.')
  end

  describe '.deliver_invitation!' do
    before(:each) do
      Notifier.stub!(:deliver_invitation)
    end

    it "should set the sent_at date" do
      nowish = Time.now
      Time.stub!(:now).and_return(nowish)

      @invite.sent_at.should be_nil
      @invite.deliver_invitation!
      @invite.sent_at.should == nowish
    end

    it "should send an invitation" do
      Notifier.should_receive(:deliver_invitation).with(@invite)
      @invite.deliver_invitation!
    end

    it "should not send an invitation if one was sent in the last week" do
      Notifier.should_not_receive(:deliver_invitation).with(@invite)
      recent_invite = Factory.create(:invite, :email => @invite.email, :sent_at => (7.days.ago + 1.minute))
      @invite.deliver_invitation!
    end

    it "should send an invitation if one was sent more than a week ago" do
      Notifier.should_receive(:deliver_invitation).with(@invite)
      old_invite = Factory.create(:invite, :email => @invite.email, :sent_at => (7.days.ago - 1.minute))
      @invite.deliver_invitation!
    end
  end
end
