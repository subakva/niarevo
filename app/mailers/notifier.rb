class Notifier < ActionMailer::Base
  layout 'email'

  default(
    from: ENV['NOTIFIER_DEFAULT_FROM'],
    bcc:  ENV['NOTIFIER_AUTO_CC']
  )

  def test(email)
    @recipient_name = "old friend"
    mail(subject: "Test Message", to: email)
  end

  def activation_succeeded(user)
    setup_user_email(user)
    mail(subject: "Account Activated!", to: user.email)
  end

  def password_reset_instructions(user)
    setup_user_email(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(subject: "Password Reset Instructions", to: user.email)
  end

  def activation_instructions(user)
    setup_user_email(user)
    @edit_activation_url = edit_activation_url(user.perishable_token)
    mail(subject: "Activation Instructions", to: user.email)
  end

  def invitation(invite)
    @invite = invite
    @recipient_name = invite.recipient_name

    subject = "#{invite.user.username} has invited you to try DreamTagger"
    mail(subject: subject, to: invite.email)
  end

  protected

  def setup_user_email(user)
    @recipient_name = user.username
    @user = user
  end
end
