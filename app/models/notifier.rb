class Notifier < ActionMailer::Base
  layout 'email'

  default_url_options[:host] = "www.niarevo.com"
  
  def activation_succeeded(user)
    subject       "Account Activated!"
    from          "NiaRevo <noreply@niarevo.com>"
    recipients    user.email
    sent_on       Time.now
    body          :user => user
  end

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "NiaRevo <noreply@niarevo.com>"
    recipients    user.email
    sent_on       Time.now
    body          :user => user,
                  :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "NiaRevo <noreply@niarevo.com>"
    recipients    user.email
    sent_on       Time.now
    body          :user => user,
                  :edit_activation_url => edit_activation_url(user.perishable_token)
  end
end
