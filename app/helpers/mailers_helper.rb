module MailersHelper
  def club_email
    'bluetrolley2014@gmail.com'
  end

  def admin_email
    'michael.protsenko@gmail.com'
  end

  def club_url
    "https://bluetrolley2014.herokuapp.com"
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

  def participant_created_subject
    'new participant registered'
  end

  def participant_approved_subject
    'participant registration confirmed'
  end

  def sender
    'Blue Trolley'
  end
end
