require File.dirname(__FILE__) + '/../spec_helper'

describe DreamsController do
  describe :get => :preview, :dream => {:description => 'Description'} do
    before(:each) do
      @dream = Dream.new
    end

    expects :new, :on => Dream,
      :with => { 'description' => 'Description'},
      :returns => proc{ @dream }
    should_assign_to :dream, :with => proc{ @dream }
    should_render_template :partial => :dream, :layout => nil, :object => proc{@dream}
  end
end
