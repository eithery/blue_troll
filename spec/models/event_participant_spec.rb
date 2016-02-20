# Eithery Lab, 2016.
# EventParticipant model specs.

require 'rails_helper'

describe EventParticipant do
  subject { FactoryGirl.build :event_participant, :with_event_crew }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :event, :event_crew, :participant }
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

  it { should belong_to(:event_crew).inverse_of :participants }
  it { should belong_to :participant }


  describe 'validation' do
  end
end

=begin
  def   describe "#ticket code" do
    context "for new participant" do
      let(:new_participant) { FactoryGirl.build(:gaby) }
      subject { new_participant }
      its(:ticket_code) { should_not be_blank }
    end

    its(:ticket_code) { should have_at_least(10).symbols }
  end

  describe "#approved?" do
    context "when NOT approved by crew lead" do
      before { gwen.approved_at = nil }
      its(:approved?) { should be false }
    end

    context "when approved by crew lead" do
      before { gwen.approved_at = Time.now }
      its(:approved?) { should be true }
    end
  end


  describe "#payment_sent?" do
    context "when payment is NOT sent" do
      before { gwen.payment_sent_at = nil }
      its(:payment_sent?) { should be false }
    end

    context "when payment is sent" do
      before { gwen.payment_sent_at = Time.now }
      its(:payment_sent?) { should be true }
    end
  end

  describe "#payment_received?" do
    context "when payment is NOT received by crew lead" do
      before { gwen.payment_received_at = nil }
      its(:payment_received?) { should be false }
    end

    context "when payment is received by crew lead" do
      before { gwen.payment_received_at = Time.now }
      its(:payment_received?) { should be true }
    end
  end


  describe "#payment_confirmed?" do
    context "when payment is NOT confirmed by financier" do
      before { gwen.payment_confirmed_at = nil }
      its(:payment_confirmed?) { should be false }
    end

    context "when payment is confirmed by financier" do
      before { gwen.payment_confirmed_at = Time.now }
      its(:payment_confirmed?) { should be true }
    end
  end

  describe "#approve" do
    before do
      gwen.approve crew_lead
      gwen.reload
    end

    its(:approved?) { should be true }
    its(:approved_at) { should_not be_blank }
    its(:approved_by) { should == crew_lead.login }
  end


  describe "#send_payment" do
    before do
      payment = Payment.new(gwen.user_account, amount: 45.0, payment_type: PaymentType::CASH)
      gwen.send_payment payment
      gwen.reload
    end

    its(:payment_sent?) { should be true }
    its(:payment_sent_at) { should_not be_blank }
    its(:payment_sent_by) { should == gwen.user_account.login }
  end


  describe "#receive_payment" do
    before do
      gwen.receive_payment 45.00, crew_lead
      gwen.reload
    end

    its(:payment_received?) { should be true }
    its(:payment_received_at) { should_not be_blank }
    its(:payment_received_by) { should == crew_lead.login }
  end


  describe "#confirm_payment" do
    before do
      gwen.confirm_payment 45.00, financier
      gwen.reload
    end

    its(:payment_confirmed?) { should be true }
    its(:payment_confirmed_at) { should_not be_blank }
    its(:payment_confirmed_by) { should == financier.login }
  end
  describe ".find_by_ticket" do
    context "when ticket code is valid" do
      it "returns participant for specified ticket code" do
        valid_ticket_code = gwen.ticket_code.to_i(16).to_s
        Participant.find_by_ticket(valid_ticket_code).should == gwen
      end
    end

    context "when ticket code is not valid" do
      it "returns nil" do
        invalid_ticket_code = '1234567890'
        Participant.find_by_ticket(invalid_ticket_code).should be_nil
      end
    end
  end
end
