class PaymentsMailer < ActionMailer::Base
  include MailersHelper

  def payment_sent(user, payment)
  end


  def payment_received(participant)
  end


  def payment_confirmed(participant)
  end
end
