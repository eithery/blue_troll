# Eithery Lab, 2016.
# EventParticipant model specs.

require 'rails_helper'

describe EventParticipant do
  subject(:participant) { FactoryGirl.build :event_participant, :with_event_crew }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :event, :crew, :person, :name }
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
    context 'when a participant crew is not specified' do
      before { participant.crew = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :crew }
    end

    context 'when a person is not specified' do
      before { participant.person = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :person }
    end
  end


  describe '#event' do
    it 'is retrieved from a crew' do
      expect(participant.event).to eq participant.crew.event
    end
  end


  describe '#name' do
    it { expect(participant.name).to eq participant.person.display_name }
  end


  describe '#ticket_code' do
    context 'for a just created participant' do
      it { expect(participant.ticket_code).to be nil }
    end

    context 'when a participant is approved' do
      include_context 'upcoming event'
      before { participant.approve crew_lead }

      it { expect(participant.ticket_code).to_not be nil }
      it { expect(participant.ticket_code).to have(10).characters }
      it { should validate_length_of(:ticket_code).is_equal_to 10 }
      it { should validate_uniqueness_of(:ticket_code).case_insensitive }
    end
  end


  describe '#approved?' do
    context 'when NOT approved by a crew lead' do
      before { participant.approved_at = nil }
      it { expect(participant.approved?).to be false }
    end

    context 'when approved by a crew lead' do
      before { participant.approved_at = Time.now }
      it { expect(participant.approved?).to be true }
    end
  end


  describe '#checked_in?' do
    context 'when NOT checked in the gate' do
      before { participant.checked_in_at = nil }
      it { expect(participant.checked_in?).to be false }
    end

    context 'when checked in the gate' do
      before { participant.checked_in_at = Time.now }
      it { expect(participant.checked_in?).to be true }
    end
  end


  describe '#paid?, #unpaid?' do
    context 'for a new participant' do
      it { expect(EventParticipant.new.paid?).to be false }
      it { expect(EventParticipant.new.unpaid?).to be true }
    end

    context 'when a payment was sent' do
      before { participant.payment_sent_at = Time.now }

      it { expect(participant.paid?).to be false }
      it { expect(participant.unpaid?).to be true }
    end

    context 'when a payment was sent and received by crew lead' do
      before do
        participant.payment_sent_at = Time.now
        participant.payment_received_at = Time.now
      end

      it { expect(participant.paid?).to be false }
      it { expect(participant.unpaid?).to be true }
    end

    context 'when a payment was sent, received, and confirmed by a crew lead' do
      before do
        participant.payment_sent_at = Time.now
        participant.payment_received_at = Time.now
        participant.payment_confirmed_at = Time.now
      end

      it { expect(participant.paid?).to be true }
      it { expect(participant.unpaid?).to be false }
    end
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
    include_context 'upcoming event'

    context 'for newly created participant' do
      it { expect(participant).to_not be_approved }
      it { expect(participant.approved_at).to be nil }
      it { expect(participant.approved_by).to be nil }
    end

    context 'when approver is a valid crew lead' do
      before do
        participant.approve crew_lead
        participant.reload
      end

      it { expect(participant).to be_approved }
      it { expect(participant.approved_at).to_not be_blank }
      it { expect(participant.approved_by).to eq crew_lead.name }
    end

    context 'when a crew lead is NOT specified' do
      it { expect { participant.approve nil }.to raise_error Exceptions::InvalidCrewLeadError,
        'Crew lead is not specified' }
    end

    context 'when an approver belongs to another crew' do
      it { expect { participant.approve other_crew_lead }.to raise_error Exceptions::InvalidCrewLeadError,
        'Crew lead belongs to another crew' }
    end

    context 'when an approver is not a crew lead' do
      it { expect { participant.approve participant }.to raise_error Exceptions::InvalidCrewLeadError,
        'Approver is not a crew lead' }
    end
  end


  describe '#send_payment' do
    include_context 'upcoming event'

    context 'for newly created participant' do
      it { expect(participant).to_not be_payment_sent }
      it { expect(participant.payment_sent_at).to be nil }
      it { expect(participant.payment_sent_by).to be nil }
    end

    context 'when a payment is sent' do
      let(:payer) { participant }

      before do
        payment = Payment.new payer, amount: 45.0, payment_type: Payment::CASH
        participant.send_payment payment
        participant.reload
      end

      it { expect(participant).to be_payment_sent }
      it { expect(participant.payment_sent_at).to_not be_blank }
      it { expect(participant.payment_sent_by).to eq payer.name }
      it { expect(participant.cash?).to be true }
    end
  end


  describe '#receive_payment' do
    include_context 'upcoming event'

    context 'for newly created participant' do
      it { expect(participant).to_not be_payment_received }
      it { expect(participant.payment_received_at).to be nil }
      it { expect(participant.payment_received_by).to be nil }
    end

    context 'when a payment is received' do
      before do
        participant.receive_payment crew_lead
        participant.reload
      end

      it { expect(participant).to be_payment_received }
      it { expect(participant.payment_received_at).to_not be_blank }
      it { expect(participant.payment_received_by).to eq crew_lead.name }
    end

    context 'when a crew lead is NOT specified' do
      it { expect { participant.receive_payment nil }.to raise_error Exceptions::InvalidCrewLeadError,
        'Crew lead is not specified' }
    end

    context 'when a payment receiver belongs to another crew' do
      it { expect { participant.receive_payment other_crew_lead }.to raise_error Exceptions::InvalidCrewLeadError,
        'Crew lead belongs to another crew' }
    end

    context 'when a payment receiver is not a crew lead' do
      it { expect { participant.receive_payment participant }.to raise_error Exceptions::InvalidCrewLeadError,
        'Payment receiver is not a crew lead' }
    end
  end


  describe '#confirm_payment' do
    include_context 'upcoming event'

    context 'for newly created participant' do
      it { expect(participant).to_not be_payment_confirmed }
      it { expect(participant.payment_confirmed_at).to be nil }
      it { expect(participant.payment_confirmed_by).to be nil }
    end

    context 'when a payment is confirmed' do
      before do
        participant.confirm_payment financier
        participant.reload
      end

      it { expect(participant).to be_payment_confirmed }
      it { expect(participant.payment_confirmed_at).to_not be_blank }
      it { expect(participant.payment_confirmed_by).to eq financier.name }
    end

    context 'when a financier is NOT specified' do
      it { expect { participant.confirm_payment nil }.to raise_error Exceptions::InvalidFinancierError,
        'Financier is not specified' }
    end

    context 'when payment confirmer is not a financier' do
      it { expect { participant.confirm_payment participant }.to raise_error Exceptions::InvalidFinancierError,
        'Payment confirmer is not a financier' }
    end
  end


  describe '#status' do
    context 'for a new participant' do
      it { expect(participant.status).to eq EventParticipant::AWAITING_APPROVAL }
    end

    context 'when a participant is approved' do
      before { participant.approved_at = Time.now }
      it { expect(participant.status).to eq EventParticipant::ACCEPTED }
    end

    context 'when a payment was sent' do
      before do
        participant.approved_at = Time.now
        participant.payment_sent_at = Time.now
      end

      it { expect(participant.status).to eq EventParticipant::PAYMENT_SENT }
    end

    context 'when a payment was sent and received by crew lead' do
      before do
        participant.approved_at = Time.now
        participant.payment_sent_at = Time.now
        participant.payment_received_at = Time.now
      end

      it { expect(participant.status).to eq EventParticipant::PAYMENT_RECEIVED }
    end

    context 'when a payment was sent, received, and confirmed by a crew lead' do
      before do
        participant.approved_at = Time.now
        participant.payment_sent_at = Time.now
        participant.payment_received_at = Time.now
        participant.payment_confirmed_at = Time.now
      end

      it { expect(participant.status).to eq EventParticipant::PAYMENT_CONFIRMED }
    end
  end
end
