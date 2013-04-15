require 'spec_helper'

describe Invite do
  before { Timecop.freeze }
  after { Timecop.return }

  let(:invite) { FactoryGirl.create(:invite, :unsent) }

  it "does not create an invite for a current user" do
    user = invite.user
    invite = Invite.new(:email => user.email)
    invite.should_not be_valid
    invite.should have(1).error_on(:base)
    invite.errors[:base].should include('An account already exists for that email.')
  end

  describe '.deliver_invitation!' do
    before(:each) do
      Notifier.stub!(:invitation).and_return(stub(deliver: true))
    end

    it "sets the sent_at date" do
      invite.sent_at.should be_nil
      invite.deliver_invitation!
      invite.sent_at.should == Time.zone.now
    end

    it "sends an invitation" do
      Notifier.should_receive(:invitation).with(invite).and_return(stub(deliver: true))
      invite.deliver_invitation!
    end

    it "does not send an invitation if one was sent in the last week" do
      Notifier.should_not_receive(:invitation)
      recent_invite = FactoryGirl.create(:invite, email: invite.email, sent_at: (7.days.ago + 1.minute))
      invite.deliver_invitation!
    end

    it "sends an invitation if one was sent more than a week ago" do
      Notifier.should_receive(:invitation).with(invite).and_return(stub(deliver: true))
      old_invite = FactoryGirl.create(:invite, email: invite.email, sent_at: (7.days.ago - 1.minute))
      invite.deliver_invitation!
    end
  end
end
