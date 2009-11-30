class Notifier < ActionMailer::Base
  layout 'email'

  default_url_options[:host] = configatron.notifier.url_host

  def activation_succeeded(user)
    setup_user_email(user)
    subject "Account Activated!"
  end

  def password_reset_instructions(user)
    setup_user_email(user)
    subject "Password Reset Instructions"
    body[:edit_password_reset_url] = edit_password_reset_url(user.perishable_token)
  end

  def activation_instructions(user)
    setup_user_email(user)
    subject "Activation Instructions"
    body[:edit_activation_url] = edit_activation_url(user.perishable_token)
  end
  
  def invitation(invite)
    setup_email(invite.email)
    subject "#{invite.user.username} has invited you to try DreamTagger"
    body[:invite] = invite
    body[:recipient_name] = invite.recipient_name
  end

  protected

  def setup_email(to_email)
    from      configatron.notifier.from
    recipients  to_email
    bcc       configatron.notifier.auto_cc
    sent_on   Time.now.utc
  end

  def setup_user_email(user)
    setup_email(user.email)
    body[:recipient_name] = user.username
    body[:user] = user
  end

end
