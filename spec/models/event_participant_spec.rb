# Eithery Lab, 2016.
# EventParticipant model specs.

require 'rails_helper'

describe EventParticipant do
  subject(:participant) { FactoryGirl.build :event_participant, :with_event_crew }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :event, :crew, :person }
  it { should respond_to :ticket_code }
  it { should respond_to :crew_lead?, :financier?, :gatekeeper? }
  it { should respond_to :flagged?, :notes }
  it { should respond_to :approved?, :approved_at, :approved_by }
  it { should respond_to :checked_in?, :checked_in_at, :checked_in_by }
  it { should respond_to :payment_type, :payment_sent_at, :payment_sent_by, :payment_notes }
  it { should respond_to :payment_sent?, :payment_received?, :payment_confirmed? }
  it { should respond_to :payment_received_at, :payment_received_by, :payment_confirmed_at, :payment_confirmed_by }
  it { should respond_to :approve, :send_payment, :receive_payment, :confirm_payment }
  it { should respond_to :unpaid?, :paid?, :status }

  it { should have_db_index :event_crew_id }
  it { should have_db_index :participant_id }
  it { should have_db_index(:ticket_code).unique }

  it { should belong_to(:crew).class_name(EventCrew).with_foreign_key(:event_crew_id).inverse_of :participants }
  it { should belong_to(:person).class_name(Participant).with_foreign_key :participant_id }


  describe 'validation' do
  end


  describe '#event' do
  end


  describe '#ticket_code' do
    context 'when a just created participant' do
    end

    context 'when a participant is approved' do
#      it { should validate_length_of(:ticket_code).is_exactly(10).symbols }
    end
  end


  describe '#approved?' do
    context "when NOT approved by a crew lead" do
      before { participant.approved_at = nil }
      it { expect(participant.approved?).to be false }
    end

    context "when approved by a crew lead" do
      before { participant.approved_at = Time.now }
      it { expect(participant.approved?).to be true }
    end
  end


  describe '#checked_in?' do
  end


  describe '#unpaid?' do
  end


  describe '#paid?' do
  end


  describe '#payment_sent?' do
    context "when payment is NOT sent" do
      before { participant.payment_sent_at = nil }
      it { expect(participant.payment_sent?).to be false }
    end

    context "when payment is sent" do
      before { participant.payment_sent_at = Time.now }
      it { expect(participant.payment_sent?).to be true }
    end
  end


  describe '#payment_received?' do
    context "when payment is NOT received by a crew lead" do
      before { participant.payment_received_at = nil }
      it { expect(participant.payment_received?).to be false }
    end

    context "when payment is received by a crew lead" do
      before { participant.payment_received_at = Time.now }
      it { expect(participant.payment_received?).to be true }
    end
  end


  describe '#payment_confirmed?' do
    context "when payment is NOT confirmed by a financier" do
      before { participant.payment_confirmed_at = nil }
      it { expect(participant.payment_confirmed?).to be false }
    end

    context "when payment is confirmed by a financier" do
      before { participant.payment_confirmed_at = Time.now }
      it { expect(participant.payment_confirmed?).to be true }
    end
  end


  describe '#approve' do
#    before do
#      gwen.approve crew_lead
#      gwen.reload
#    end

#    its(:approved?) { should be true }
#    its(:approved_at) { should_not be_blank }
#    its(:approved_by) { should == crew_lead.login }
  end


  describe '#send_payment' do
#    before do
#      payment = Payment.new(gwen.user_account, amount: 45.0, payment_type: PaymentType::CASH)
#      gwen.send_payment payment
#      gwen.reload
#    end

#    its(:payment_sent?) { should be true }
#    its(:payment_sent_at) { should_not be_blank }
#    its(:payment_sent_by) { should == gwen.user_account.login }
  end


  describe '#receive_payment' do
#    before do
#      gwen.receive_payment 45.00, crew_lead
#      gwen.reload
#    end

#    its(:payment_received?) { should be true }
#    its(:payment_received_at) { should_not be_blank }
#    its(:payment_received_by) { should == crew_lead.login }
  end


  describe '#confirm_payment' do
#    before do
#      gwen.confirm_payment 45.00, financier
#      gwen.reload
#    end

#    its(:payment_confirmed?) { should be true }
#    its(:payment_confirmed_at) { should_not be_blank }
#    its(:payment_confirmed_by) { should == financier.login }
  end


  describe '#status' do
  end
end
