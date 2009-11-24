require File.dirname(__FILE__) + '/../spec_helper'

describe Notifier do
  before(:each) do
    @user = Factory.create(:user)
  end

  describe 'an email to a user', :shared => true do
    it "uses the standard setup" do
      @mail.from.should == ['noreply@niarevo.com']
      @mail.to.should == [@user.email]
      @mail.bcc.should == ['outgoing@niarevo.com']
    end

    it "uses the notifier layout" do
      @mail.body.should =~ Regexp.new("Hello #{@user.username}")
      @mail.body.should =~ /Thanks,\nThe DreamTagger Team/
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
