class PaymentsMailer < ActionMailer::Base
  include MailersHelper

  def payment_sent(user, payment)
    target = user.crew.emails
    target += UserAccount.financier_emails if payment.payment_type.to_i == 0
    @payment = payment
    mail to: target.uniq, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{payment_sent_subject}"
  end


  def payment_received(participant)
    target = [participant.user_account.email, participant.email].uniq
    @participant = participant
    mail to: target, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{payment_received_subject}"
  end


  def payment_confirmation_requested(crew_lead, participant)
    target = UserAccount.financier_emails
    @crew_lead = crew_lead
    @participant = participant
    mail to: target.uniq, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{payment_received_subject}"
  end


  def payment_confirmed(participant)
    target = [participant.user_account.email, participant.email]
    target += user.crew.emails
    @participant = participant
    mail to: target.uniq, from: "Blue_Trolley <#{club_email}>",
      subject: "#{sender}: #{payment_confirmed_subject}"
  end
end
