class UserAccountsMailer < ActionMailer::Base
  # Sends email when user created the new account in the system.
  # The email contains the link to activate the user account.
  def registered(user)
    mail_to user, "Blue Trolley: club account activation"
  end


  # Sends confirmation email when user activated her account.
  def activated(user)
    mail_to user, "Blue Trolley: account has been activated"
  end


  # Sends email contaning the link to reset user's password.
  def password_reset(user)
    mail_to user, "Blue Trolley: password reset"
  end


  # Sends notification email when password is changed.
  def password_changed(user)
    mail_to user, "Blue Trolley: password has been changed"
  end

private
  def club_email
    "Blue_Trolley <bluetrolley2014@gmail.com>"
  end

  def admin_email
    'michael.protsenko@gmail.com'
  end

  def mail_to(user, subject)
    @user = user
    mail to: @user.email, bcc: admin_email, from: club_email, subject: subject
  end
end
