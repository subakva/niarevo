require 'spec_helper'
require 'facebook_signature'

describe FacebookSignature do
  before(:each) do
    @params = {
      "not_important"=>"ignore",
      "fb_sig_app_id"=>"350262900480",
      "fb_sig_locale"=>"en_US",
      "fb_sig_in_new_facebook"=>"1",
      "fb_sig"=>"89b043813b5bbb2c65b46e61d84b241f",
      "fb_sig_added"=>"0",
      "fb_sig_api_key"=>"a87d6b33c69134a64fe259c6d0a1355f",
      "fb_sig_uninstall"=>"1",
      "fb_sig_time"=>"1261961174.3472",
      "fb_sig_user"=>"663123948"
    }
    @secret = 'configatron.fb_connect.secret'
  end

  describe '#calculate' do
    before(:each) do
      @params.delete("fb_sig")
    end

    it "raises an error if the secret is missing" do
      lambda {
        FacebookSignature.calculate(nil, @params)
      }.should raise_error(ArgumentError, 'The Facebook secret key is required to verify the signature.')
    end

    it "calculates the signature for a set of fb_sig_XXXXX params" do
      FacebookSignature.calculate(@secret, @params).should == '89b043813b5bbb2c65b46e61d84b241f'
    end
  end

  describe '#valid?' do

    it "raises an error if the fb_sig param is missing" do
      lambda {
        FacebookSignature.valid?(@secret, {})
      }.should raise_error(ArgumentError, 'The fb_sig param is required to verify the signature.')
    end

    it "raises an error if the secret is missing" do
      lambda {
        FacebookSignature.valid?(nil, @params)
      }.should raise_error(ArgumentError, 'The Facebook secret key is required to verify the signature.')
    end

    it "returns true if the params are valid" do
      FacebookSignature.valid?(@secret, @params).should be_true
    end

    it "returns false if the secret is incorrect" do
      FacebookSignature.valid?('not the secret', @params).should be_false
    end

    it "returns false if one of the sig values has been altered" do
      @params["fb_sig_user"] = '00000000'
      FacebookSignature.valid?(@secret, @params).should be_false
    end

    it "returns false if one of the sig values is missing" do
      @params.delete("fb_sig_user")
      FacebookSignature.valid?(@secret, @params).should be_false
    end
  end

end
