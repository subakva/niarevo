# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string(32)       not null
#  email               :string(255)      not null
#  crypted_password    :string(255)      not null
#  password_salt       :string(255)      not null
#  persistence_token   :string(255)      not null
#  single_access_token :string(255)      not null
#  perishable_token    :string(255)      not null
#  login_count         :integer          default(0), not null
#  failed_login_count  :integer          default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(46)
#  last_login_ip       :string(46)
#  active              :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user, :inactive) }

  before do
    allow(Notifier).to receive(:activation_succeeded).and_return(double(deliver: true))
    allow(Notifier).to receive(:activation_instructions).and_return(double(deliver: true))
    allow(Notifier).to receive(:password_reset_instructions).and_return(double(deliver: true))
  end

  describe '#gravatar_url' do
    it "generates a gravatar url" do
      user.email = 'gravatar@example.com'
      expect(user.gravatar_url).to eq(
        'https://secure.gravatar.com/avatar/0cef130e32e054dd516c99e5181d30c4.png?r=PG'
      )
    end
  end

  describe '.find_by_username_or_email' do
    it "finds an account by username or email" do
      expect(User.find_by_username_or_email(username: user.username)).to eq(user)
      expect(User.find_by_username_or_email(email: user.email)).to eq(user)
      expect(User.find_by_username_or_email(username_or_email: user.username)).to eq(user)
      expect(User.find_by_username_or_email(username_or_email: user.email)).to eq(user)
    end
  end

  describe '#activate!' do
    context 'for an unactivated user' do
      it "sets the active flag to true and sends an email" do
        expect(Notifier).to receive(:activation_succeeded).with(user).and_return(double(deliver: true))
        user.activate!
        user.reload
        expect(user).to be_active
      end
    end

    context 'for an activated user' do
      before { user.update_attribute(:active, true) }

      it "does not send an email if the account is already active" do
        expect(Notifier).to_not receive(:activation_succeeded)
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
      expect(Notifier).to receive(:activation_instructions).with(user).and_return(double(deliver: true))

      user.deliver_activation_instructions!

      expect(user.perishable_token).to_not eq(original_token)
    end
  end

  describe '#deliver_password_reset_instructions!' do
    let!(:original_token) { user.perishable_token }

    it "resets the token and sends an email" do
      expect(Notifier).to receive(:password_reset_instructions).with(user).and_return(double(deliver: true))

      user.deliver_password_reset_instructions!

      expect(user.perishable_token).to_not eq(original_token)
    end
  end
end
