# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  username               :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
    @user = Factory.create(:user)
  end

  should_validate_uniqueness_of :username
  should_validate_uniqueness_of :email
  should_validate_uniqueness_of :persistence_token
  should_validate_uniqueness_of :single_access_token
  should_validate_uniqueness_of :perishable_token
  should_validate_confirmation_of :password

  should_have_many :dreams

  it "should be gravtastic" do
    @user.email = 'gravatar@example.com'
    @user.gravatar_url.should == 'http://gravatar.com/avatar/0cef130e32e054dd516c99e5181d30c4.png?r=PG'
  end
end
