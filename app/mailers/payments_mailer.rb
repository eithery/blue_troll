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
  end


  def payment_confirmed(participant)
  end
end
