class Payment
  attr_reader :payer, :payees, :payment_type, :amount, :notes

  PAYPAL = EventParticipant.payment_types[:paypal]
  CHECK = EventParticipant.payment_types[:check]
  CASH = EventParticipant.payment_types[:cash]
  OTHER = EventParticipant.payment_types[:other]


  def initialize(payer, payment_options)
    @payer = payer
    @payment_type = payment_options[:payment_type]
    @amount = payment_options[:amount]
    @notes = payment_options[:notes]
    @payee_id = payment_options[:payee]

#    @payees = @payer.participants.to_a.select { |p| p.unpaid? }
#    @payees = @payees.select { |p| p.id == @payee_id } unless @payee_id.blank?
  end


  def payment_type_string
    "Pay Pal" if payment_type.to_i == 0
    "Check" if payment_type.to_i == 1
    "Cash" if payment_type.to_i == 2
    "Other"
  end
end
