require File.dirname(__FILE__) + '/../spec_helper'

describe Notifier do
  before(:each) do
    @user = Factory.create(:user)
  end

  describe 'all emails', :shared => true do
    it "uses the standard setup" do
      @mail.from.should == ['noreply@dreamtagger.com']
      @mail.bcc.should == ['outgoing@dreamtagger.com']
    end

    it "uses the notifier layout" do
      @mail.body.should =~ /Thanks,\nThe DreamTagger Team/
    end
  end

  describe 'an email to a user', :shared => true do
    it_should_behave_like 'all emails'

    it "sends the email to the user" do
      @mail.to.should == [@user.email]
    end

    it "includes the greeting" do
      @mail.body.should =~ Regexp.new("Hello #{@user.username}")
    end
  end

  describe 'test' do
    before(:each) do
      @mail = Notifier.create_test('test@example.com')
    end
    
    it_should_behave_like 'all emails'

    it "sends the email to the tester" do
      @mail.to.should == ['test@example.com']
    end

    it "sets the subject" do
      @mail.subject.should == "Test Message"
    end
  end

  describe 'invitation' do
    before(:each) do
      @invite = Factory.create(:invite, :user => @user)
      @mail = Notifier.create_invitation(@invite)
    end

    it_should_behave_like 'all emails'

    it "sends the email to the invitee" do
      @mail.to.should == [@invite.email]
    end

    it "sets the subject" do
      @mail.subject.should == "#{@user.username} has invited you to try DreamTagger"
    end

    it "includes the greeting" do
      @mail.body.should =~ Regexp.new("Hello #{@invite.recipient_name}")
    end

    it "includes the message" do
      @mail.body.should =~ Regexp.new(@invite.message)
    end

    it "includes the new account link" do
      @mail.body.should =~ Regexp.new("http://localhost:3000/account/new")
    end

    it "includes the about link" do
      @mail.body.should =~ Regexp.new("http://localhost:3000/about")
    end
    
  end

  describe 'activation_instructions' do
    before(:each) do
      @mail = Notifier.create_activation_instructions(@user)
    end

    it_should_behave_like 'an email to a user'

    it "sets the subject" do
      @mail.subject.should == 'Activation Instructions'
    end

    it "includes the activation link" do
      @mail.body.should =~ Regexp.new("http://localhost:3000/activations/#{@user.perishable_token}/edit")
    end
  end

  describe 'password_reset_instructions' do
    before(:each) do
      @mail = Notifier.create_password_reset_instructions(@user)
    end
  
    it_should_behave_like 'an email to a user'
  
    it "sets the subject" do
      @mail.subject.should == 'Password Reset Instructions'
    end
  
    it "includes the password reset link" do
      @mail.body.should =~ Regexp.new("http://localhost:3000/password_resets/#{@user.perishable_token}/edit")
    end
  end

  describe 'activation_succeeded' do
    before(:each) do
      @mail = Notifier.create_activation_succeeded(@user)
    end
  
    it_should_behave_like 'an email to a user'
  
    it "sets the subject" do
      @mail.subject.should == 'Account Activated!'
    end
  end
end
