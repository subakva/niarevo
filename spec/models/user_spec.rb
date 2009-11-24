# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  username            :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  active              :boolean(1)      not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
    @user = Factory.create(:user)
    Notifier.stub!(:deliver_activation_success)
    Notifier.stub!(:deliver_activation_success)
    Notifier.stub!(:deliver_activation_instructions).with(@user)
  end

  should_validate_uniqueness_of :username
  should_validate_uniqueness_of :email
  should_validate_uniqueness_of :persistence_token
  should_validate_uniqueness_of :single_access_token
  should_validate_uniqueness_of :perishable_token
  should_validate_confirmation_of :password
  should_validate_exclusion_of :username, :in => ['admin', 'user', 'anonymous']

  should_allow_mass_assignment_of :email, :username, :password, :password_confirmation

  should_have_many :dreams

  it "should be gravtastic" do
    @user.email = 'gravatar@example.com'
    @user.gravatar_url.should == 'http://gravatar.com/avatar/0cef130e32e054dd516c99e5181d30c4.png?r=PG'
  end

  it "should be able to find an account by username or email" do
    User.find_by_username_or_password(:username => @user.username).should == @user
    User.find_by_username_or_password(:email => @user.email).should == @user
    User.find_by_username_or_password(:username_or_email => @user.username).should == @user
    User.find_by_username_or_password(:username_or_email => @user.email).should == @user
  end

  it "should set the active flag to tru and send an email when requested" do
    Notifier.should_receive(:deliver_activation_succeeded).with(@user)
    @user.activate!
    @user.reload
    @user.should be_active
  end

  it "should not send an email if the account is already active" do
    @user.update_attribute(:active, true)
    Notifier.should_not_receive(:deliver_activation_success).with(@user)
    @user.activate!
  end

  it "should reset the token and send an email when activation instructions are requested" do
    original_token = @user.perishable_token
    Notifier.should_receive(:deliver_activation_instructions).with(@user)

    @user.deliver_activation_instructions!

    @user.perishable_token.should_not == original_token
  end

  it "should reset the token and send an email when password reset instructions are requested" do
    original_token = @user.perishable_token
    Notifier.should_receive(:deliver_password_reset_instructions).with(@user)

    @user.deliver_password_reset_instructions!

    @user.perishable_token.should_not == original_token
  end
end
