# Eithery Lab, 2016.
# Payment model.
# Represents a payment.

class Payment
  attr_reader :payer, :payees, :payment_type, :amount, :notes

  PAYPAL = EventParticipant.payment_types[:paypal]
  CHECK = EventParticipant.payment_types[:check]
  CASH = EventParticipant.payment_types[:cash]
  OTHER = EventParticipant.payment_types[:other]


  def initialize(payer:, payment_type:, payees: [], amount: 0, notes: nil)
    @payer = payer
    @payment_type = payment_type
    @payees = payees
    @amount = amount
    @notes = notes
  end


  def payment_type_string
    return 'Pay Pal' if payment_type == PAYPAL
    return 'Check' if payment_type == CHECK
    return 'Cash' if payment_type == CASH
    return 'Other'
  end
end
