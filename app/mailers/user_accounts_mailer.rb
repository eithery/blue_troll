class UserAccountsMailer < ActionMailer::Base
  include MailersHelper

  # Sends email when user created the new account in the system.
  # The email contains the link to activate the user account.
  def registered(user)
    mail_to user, registered_subject
  end


  # Sends confirmation email when user activated her account.
  def activated(user)
    mail_to user, activated_subject
  end


  # Sends email contaning the link to reset user's password.
  def password_reset(user)
    mail_to user, password_reset_subject
  end


  # Sends notification email when password is changed.
  def password_changed(user)
    mail_to user, password_changed_subject
  end
end
