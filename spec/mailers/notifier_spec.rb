require 'spec_helper'

describe Notifier do
  let(:user) { FactoryGirl.create(:user) }

  shared_examples_for 'all emails' do
    it "uses the standard setup" do
      mail.from.should == ['noreply@dreamtagger.com']
      mail.bcc.should == ['outgoing@dreamtagger.com']
    end

    it "uses the notifier layout" do
      mail.body.should =~ /Thanks,<br \/>The DreamTagger Team/
    end
  end

  shared_examples_for 'an email to a user' do
    it_should_behave_like 'all emails'

    it "sends the email to the user" do
      mail.to.should == [user.email]
    end

    it "includes the greeting" do
      mail.body.should =~ Regexp.new("Hello #{user.username}")
    end
  end

  describe 'test' do
    let(:mail) { Notifier.test('test@example.com') }

    it_should_behave_like 'all emails'

    it "sends the email to the tester" do
      mail.to.should == ['test@example.com']
    end

    it "sets the subject" do
      mail.subject.should == "Test Message"
    end
  end

  describe 'invitation' do
    let(:invite) { FactoryGirl.create(:invite, user: user) }
    let(:mail) { Notifier.invitation(invite) }

    it_should_behave_like 'all emails'

    it "sends the email to the invitee" do
      mail.to.should == [invite.email]
    end

    it "sets the subject" do
      mail.subject.should == "#{user.username} has invited you to try DreamTagger"
    end

    it "includes the greeting" do
      mail.body.should =~ Regexp.new("Hello #{invite.recipient_name}")
    end

    it "includes the message" do
      mail.body.should =~ Regexp.new(invite.message)
    end

    it "includes the new account link" do
      mail.body.should =~ Regexp.new("http://niarevo.dev/account/new")
    end

    it "includes the about link" do
      mail.body.should =~ Regexp.new("http://niarevo.dev/about")
    end

  end

  describe 'activation_instructions' do
    let(:mail) { Notifier.activation_instructions(user) }

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      mail.subject.should == 'Activation Instructions'
    end

    it "includes the activation link" do
      mail.body.should =~ Regexp.new("http://niarevo.dev/activations/#{user.perishable_token}/edit")
    end
  end

  describe 'password_reset_instructions' do
    let(:mail) { Notifier.password_reset_instructions(user) }

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      mail.subject.should == 'Password Reset Instructions'
    end

    it "includes the password reset link" do
      mail.body.should =~ Regexp.new("http://niarevo.dev/password_resets/#{user.perishable_token}/edit")
    end
  end

  describe 'activation_succeeded' do
    let(:mail) { Notifier.activation_succeeded(user) }

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      mail.subject.should == 'Account Activated!'
    end
  end
end
