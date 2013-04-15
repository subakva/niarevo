require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user, :inactive) }

  before do
    Notifier.stub(:activation_succeeded).and_return(stub(deliver: true))
    Notifier.stub(:activation_instructions).and_return(stub(deliver: true))
    Notifier.stub(:password_reset_instructions).and_return(stub(deliver: true))
  end

  it "generates a gravater url" do
    user.email = 'gravatar@example.com'
    user.gravatar_url.should == 'https://secure.gravatar.com/avatar/0cef130e32e054dd516c99e5181d30c4.png?r=PG'
  end

  it "finds an account by username or email" do
    User.find_by_username_or_password(:username => user.username).should == user
    User.find_by_username_or_password(:email => user.email).should == user
    User.find_by_username_or_password(:username_or_email => user.username).should == user
    User.find_by_username_or_password(:username_or_email => user.email).should == user
  end

  it "sets the active flag to true and send an email when requested" do
    Notifier.should_receive(:activation_succeeded).with(user).and_return(stub(deliver: true))
    user.activate!
    user.reload
    user.should be_active
  end

  it "does not send an email if the account is already active" do
    user.update_attribute(:active, true)
    Notifier.should_not_receive(:activation_succeeded)
    user.activate!
  end

  it "resets the token and sends an email when activation instructions are requested" do
    original_token = user.perishable_token
    Notifier.should_receive(:activation_instructions).with(user).and_return(stub(deliver: true))

    user.deliver_activation_instructions!

    user.perishable_token.should_not == original_token
  end

  it "resets the token and sends an email when password reset instructions are requested" do
    original_token = user.perishable_token
    Notifier.should_receive(:password_reset_instructions).with(user).and_return(stub(deliver: true))

    user.deliver_password_reset_instructions!

    user.perishable_token.should_not == original_token
  end
end
