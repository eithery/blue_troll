class Payment
  attr_reader :payer, :payment_type, :amount, :notes

  def initialize(payer, payment_options)
    @payer = payer
    @payment_type = payment_options[:payment_type]
    @amount = payment_options[:amount]
    @notes = payment_options[:notes]
    @payee_id = payment_options[:payee]
  end


  def payees
    payees = @payer.participants.to_a.select { |p| p.unpaid? }
    payees.select! { |p| p.id == @payee_id } unless @payee_id.blank?
    payees
  end


  def payment_type_string
    "Pay Pal" if payment_type.to_i == 0
    "Check" if payment_type.to_i == 1
    "Cash" if payment_type.to_i == 2
    "Other"
  end
end
