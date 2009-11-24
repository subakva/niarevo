class Notifier < ActionMailer::Base
  layout 'email'

  default_url_options[:host] = configatron.notifier.url_host

  def activation_succeeded(user)
    setup_email(user)
    subject "Account Activated!"
  end

  def password_reset_instructions(user)
    setup_email(user)
    subject "Password Reset Instructions"
    body[:edit_password_reset_url] = edit_password_reset_url(user.perishable_token)
  end

  def activation_instructions(user)
    setup_email(user)
    subject "Activation Instructions"
    body[:edit_activation_url] = edit_activation_url(user.perishable_token)
  end
  
  protected

  def setup_email(user)
    from          configatron.notifier.from
    recipients    user.email
    bcc           configatron.notifier.auto_cc
    sent_on       Time.now
    body[:user] = user
  end

end
