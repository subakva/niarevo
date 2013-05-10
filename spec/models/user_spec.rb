require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user, :inactive) }

  before do
    Notifier.stub(:activation_succeeded).and_return(stub(deliver: true))
    Notifier.stub(:activation_instructions).and_return(stub(deliver: true))
    Notifier.stub(:password_reset_instructions).and_return(stub(deliver: true))
  end

  describe '#gravatar_url' do
    it "generates a gravatar url" do
      user.email = 'gravatar@example.com'
      user.gravatar_url.should == 'https://secure.gravatar.com/avatar/0cef130e32e054dd516c99e5181d30c4.png?r=PG'
    end
  end

  describe '.find_by_username_or_email' do
    it "finds an account by username or email" do
      User.find_by_username_or_email(username: user.username).should == user
      User.find_by_username_or_email(email: user.email).should == user
      User.find_by_username_or_email(username_or_email: user.username).should == user
      User.find_by_username_or_email(username_or_email: user.email).should == user
    end
  end

  describe '#activate!' do
    context 'for an unactivated user' do
      it "sets the active flag to true and sends an email" do
        Notifier.should_receive(:activation_succeeded).with(user).and_return(stub(deliver: true))
        user.activate!
        user.reload
        user.should be_active
      end
    end

    context 'for an activated user' do
      before { user.update_attribute(:active, true) }

      it "does not send an email if the account is already active" do
        Notifier.should_not_receive(:activation_succeeded)
        user.activate!
      end
    end
  end

  describe '#deactivate!' do
    context 'for an activated user' do
      before { user.update_attribute(:active, true) }

      it "changes the active flag to false" do
        expect {
          user.deactivate!
        }.to change(user.reload, :active).to(false)
      end
    end
  end

  describe '#deliver_activation_instructions!' do
    let!(:original_token) { user.perishable_token }

    it "resets the token and sends an email" do
      Notifier.should_receive(:activation_instructions).with(user).and_return(stub(deliver: true))

      user.deliver_activation_instructions!

      user.perishable_token.should_not == original_token
    end
  end

  describe '#deliver_password_reset_instructions!' do
    let!(:original_token) { user.perishable_token }

    it "resets the token and sends an email" do
      Notifier.should_receive(:password_reset_instructions).with(user).and_return(stub(deliver: true))

      user.deliver_password_reset_instructions!

      user.perishable_token.should_not == original_token
    end
  end
end
