module MailersHelper
  def club_email
    'bluetrolley2014@gmail.com>'
  end

  def admin_email
    'michael.protsenko@gmail.com'
  end

  def mail_to(user, subject)
    @user = user
    mail to: @user.email, bcc: admin_email, from: "Blue_Trolley <#{club_email}>", subject: "#{sender}: #{subject}"
  end

  def registered_subject
    'club account activation'
  end

  def activated_subject
    'account has been activated'
  end

  def password_reset_subject
    'password reset'
  end

  def password_changed_subject
    'password has been changed'
  end

  def sender
    'Blue Trolley'
  end
end
