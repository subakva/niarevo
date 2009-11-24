require File.dirname(__FILE__) + '/../spec_helper'

describe ActivationsController do
  describe :get => :index do
    should_render_template :new
  end
end
