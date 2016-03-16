module MailersHelper
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
    'registration confirmation'
  end

  def approval_request_subject
    'registration approval request'
  end

  def participant_approved_subject
    'registration approval'
  end

  def payment_sent_subject
    'payment sent'
  end

  def payment_received_subject
    'payment received'
  end

  def payment_confirmed_subject
    'payment confirmed'
  end
end
