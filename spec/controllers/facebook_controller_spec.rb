require File.dirname(__FILE__) + '/../spec_helper'

describe FacebookController do
  describe 'an action with signature validation', :shared => true do
    describe 'with a valid signature' do
      expects :valid?, :on => FacebookSignature, :returns => true
      should_respond_with :success, :layout => nil
    end

    describe 'with an invalid signature' do
      expects :valid?, :on => FacebookSignature, :returns => false
      should_respond_with 401, :body => 'Signature was not valid.', :layout => nil
    end
  end

  describe :post => :deauthorization do
    it_should_behave_like 'an action with signature validation'
  end

  describe :post => :authorization do
    it_should_behave_like 'an action with signature validation'
  end
end
