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

require 'spec_helper'

describe Invite do
  before { Timecop.freeze }
  after { Timecop.return }

  let(:invite) { FactoryGirl.create(:invite, :unsent) }

  it "does not create an invite for a current user" do
    user = invite.user
    invite = Invite.new(:email => user.email)
    expect(invite).to_not be_valid
    expect(invite.errors[:base].size).to eq(1)
    expect(invite.errors[:base]).to include('An account already exists for that email.')
  end

  describe '.deliver_invitation!' do
    before(:each) do
      allow(Notifier).to receive(:invitation).and_return(double(deliver: true))
    end

    it "sets the sent_at date" do
      expect(invite.sent_at).to be_nil
      invite.deliver_invitation!
      expect(invite.sent_at).to eq(Time.zone.now)
    end

    it "sends an invitation" do
      expect(Notifier).to receive(:invitation).with(invite).and_return(double(deliver: true))
      invite.deliver_invitation!
    end

    it "does not send an invitation if one was sent in the last week" do
      expect(Notifier).to_not receive(:invitation)
      recent_invite = FactoryGirl.create(:invite, email: invite.email, sent_at: (7.days.ago + 1.minute))
      invite.deliver_invitation!
    end

    it "sends an invitation if one was sent more than a week ago" do
      expect(Notifier).to receive(:invitation).with(invite).and_return(double(deliver: true))
      old_invite = FactoryGirl.create(:invite, email: invite.email, sent_at: (7.days.ago - 1.minute))
      invite.deliver_invitation!
    end
  end
end
