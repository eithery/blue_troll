# Eithery Lab, 2016.
# Payment model specs.

require 'rails_helper'

describe Payment do
  let(:payer) { FactoryGirl.build(:user_account) }
  subject(:payment) do
    Payment.new payer: payer,
      payment_type: Payment::CASH,
      payees: Array.new(3) { FactoryGirl.build(:event_participant) },
      amount: 60,
      notes: 'He owes more money'
  end

  it { should respond_to :payer, :payees, :payment_type, :amount, :notes }
  it { should respond_to :payment_type_string }

  it { expect(payment.payer).to be payer }
  it { expect(payment.payment_type).to be Payment::CASH }
  it { expect(payment).to have(3).payees }
  it { expect(payment.payees.first).to be_kind_of EventParticipant }
  it { expect(payment.amount).to eq 60 }
  it { expect(payment.notes).to_not be_blank }


  describe '#payment_type_string' do
    it 'returns the string representation of payment type' do
      {
        Payment::PAYPAL => 'Pay Pal',
        Payment::CHECK => 'Check',
        Payment::CASH => 'Cash',
        Payment::OTHER => 'Other'
      }.each do |type, value|
        payment = Payment.new payer: payer, payment_type: type
        expect(payment.payment_type_string).to eq value
      end
    end
  end
end
