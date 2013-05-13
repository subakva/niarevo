class FacebookController < ActionController::Base
  before_action :check_facebook_signature, :only => [:authorization, :deauthorization]

  # def registration
  #   # http://wiki.developers.facebook.com/index.php/Connect.registerUsers
  # end

  def authorization
    render :layout => nil, :text => nil
  end

  def deauthorization
    render :layout => nil, :text => nil
  end

  protected

  def check_facebook_signature
    unless FacebookSignature.valid?(configatron.fb_connect.secret, params)
      render :status => 401, :text => 'Signature was not valid.'
    end
  end
end
