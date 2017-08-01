# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notifier do
  let(:user) { FactoryGirl.create(:user) }

  shared_examples_for 'all emails' do
    it "uses the standard setup" do
      expect(mail.from).to eq(['noreply@dreamtagger.com'])
      expect(mail.bcc).to eq(['outgoing@dreamtagger.com'])
    end

    it "uses the notifier layout" do
      expect(mail.body).to match(%r{Thanks,<br \/>The DreamTagger Team})
    end
  end

  shared_examples_for 'an email to a user' do
    it_should_behave_like 'all emails'

    it "sends the email to the user" do
      expect(mail.to).to eq([user.email])
    end

    it "includes the greeting" do
      expect(mail.body).to match(Regexp.new("Hello #{user.username}"))
    end
  end

  describe 'test' do
    let(:mail) { Notifier.test('test@example.com') }

    it_should_behave_like 'all emails'

    it "sends the email to the tester" do
      expect(mail.to).to eq(['test@example.com'])
    end

    it "sets the subject" do
      expect(mail.subject).to eq("Test Message")
    end
  end

  describe 'invitation' do
    let(:invite) { FactoryGirl.create(:invite, user: user) }
    let(:mail) { Notifier.invitation(invite) }

    it_should_behave_like 'all emails'

    it "sends the email to the invitee" do
      expect(mail.to).to eq([invite.email])
    end

    it "sets the subject" do
      expect(mail.subject).to eq("#{user.username} has invited you to try DreamTagger")
    end

    it "includes the greeting" do
      expect(mail.body).to match(Regexp.new("Hello #{invite.recipient_name}"))
    end

    it "includes the message" do
      expect(mail.body).to match(Regexp.new(invite.message))
    end

    it "includes the new account link" do
      expect(mail.body).to match(Regexp.new("http://niarevo.dev/account/new"))
    end

    it "includes the about link" do
      expect(mail.body).to match(Regexp.new("http://niarevo.dev/about"))
    end
  end

  describe 'activation_instructions' do
    let(:mail) { Notifier.activation_instructions(user) }

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      expect(mail.subject).to eq('Activation Instructions')
    end

    it "includes the activation link" do
      expect(mail.body).to match(
        Regexp.new("http://niarevo.dev/activations/#{user.perishable_token}/edit")
      )
    end
  end

  describe 'password_reset_instructions' do
    let(:mail) { Notifier.password_reset_instructions(user) }

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      expect(mail.subject).to eq('Password Reset Instructions')
    end

    it "includes the password reset link" do
      expect(mail.body).to match(
        Regexp.new("http://niarevo.dev/password_resets/#{user.perishable_token}/edit")
      )
    end
  end

  describe 'activation_succeeded' do
    let(:mail) { Notifier.activation_succeeded(user) }

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      expect(mail.subject).to eq('Account Activated!')
    end
  end
end
