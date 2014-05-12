class Payment
  attr_reader :payment_type, :amount, :notes

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
  end
end
