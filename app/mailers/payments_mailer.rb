class PaymentsMailer < ActionMailer::Base
  include MailersHelper

  def payment_sent(participant)
  end


  def payment_received(participant)
  end
end
