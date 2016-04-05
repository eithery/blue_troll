# Eithery Lab, 2016.
# Event model specs.

require 'rails_helper'

describe Event do
  subject(:event) { FactoryGirl.build :event }
  let(:event_with_crews) { FactoryGirl.create :event, :with_crews }
  let(:populated_event) { FactoryGirl.create :event, :with_crews, :with_participants }
  let(:crew) { populated_event.crews.first }
  let(:crew_lead) { crew.leads.first }
  let(:participant) { crew.participants.first }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has a required unique name'
  it_behaves_like 'it has timestamps'
  it_behaves_like 'it provides statistics'

  it { should respond_to :short_name }
  it { should respond_to :started_on, :finished_on }
  it { should respond_to :address }
  it { should respond_to :notes, :tag }
  it { should respond_to :event_type }
  it { should respond_to :crews, :participants }
  it { should respond_to :participant_by_ticket }
  it { should respond_to :crew_leads, :financiers, :gatekeepers }
  it { should respond_to :crew_lead_emails, :financier_emails }

  it { should validate_presence_of :short_name }
  it { should validate_presence_of :started_on }
  it { should validate_presence_of :finished_on }
  it { should validate_presence_of :address }
  it { should validate_length_of(:short_name).is_at_most 20 }
  it { should validate_length_of(:address).is_at_most 255 }
  it { should validate_uniqueness_of(:short_name).case_insensitive }

  it { should belong_to :event_type }
  it { should have_db_index :event_type_id }
  it { should have_db_index(:short_name).unique }
  it { should have_many(:crews).class_name(EventCrew).dependent :restrict_with_exception }
  it { should have_many(:participants).through(:crews).class_name EventParticipant }


  describe 'validation' do
    context 'when the event end date less than a start date' do
      before do
        event.started_on = Date.new(2016, 03, 03)
        event.finished_on = Date.new(2016, 03, 01)
      end

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :base }
    end

    context 'when the event start date same as end date but later by time' do
      before do
        event.started_on = DateTime.now
        event.finished_on = event.started_on.to_date
      end

      it { is_expected.to be_valid }
    end

    context 'when event type is not defined' do
      before { event.event_type = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :event_type }
    end
  end


  describe '#crews' do
    it { expect(event_with_crews).to have(2).crews }
    it { expect(Event.new).to have(:no).crews }

    it 'does not allow to be deleted when has assigned crews' do
      expect { event_with_crews.destroy }.to raise_error ActiveRecord::DeleteRestrictionError
    end

    it 'can be deleted if no crews assigned' do
      event_with_crews.crews.destroy_all
      expect { event_with_crews.destroy }.to change { Event.count }.by -1
    end
  end


  describe '#participants' do
    it { expect(populated_event).to have(9).participants }
    it { expect(Event.new).to have(:no).participants }
  end


  describe '#participant_by_ticket' do
    before { participant.approve crew_lead }

    context "when a ticket code is valid" do
      it "returns a participant for specified ticket code" do
        valid_ticket = participant.ticket_code.to_i(16).to_s
        expect(participant.ticket_code).to_not be_blank
        expect(populated_event.participant_by_ticket valid_ticket).to eq participant
      end
    end

    context "when a ticket code is not valid" do
      let(:invalid_ticket) { SecureRandom.hex[0,10] }

      it { expect(populated_event.participant_by_ticket invalid_ticket).to be nil }
      it { expect(populated_event.participant_by_ticket nil).to be nil }
    end
  end


  describe '#crew_leads' do
    it 'returns all crew leads at the event' do
      expect(populated_event).to have(2).crew_leads
      populated_event.crew_leads.each { |lead| expect(lead).to be_crew_lead }
    end
  end


  describe '#crew_lead_emails' do
    it 'returns all crew_lead emails' do
      expect(populated_event).to have(2).crew_lead_emails
      populated_event.crew_lead_emails.each { |email| expect(email).to_not be_blank }
    end
  end


  describe '#financiers' do
    it 'returns all financiers at the event' do
      expect(populated_event).to have(1).financiers
      populated_event.financiers.each { |fin| expect(fin).to be_financier }
    end
  end


  describe '#financier_emails' do
    it 'returns all financier emails' do
      expect(populated_event).to have(1).financier_emails
      populated_event.financier_emails.each { |email| expect(email).to_not be_blank }
    end
  end


  describe '#gatekeepers' do
    it 'returns all gatekeepers at the event' do
      expect(populated_event).to have(4).gatekeepers
      populated_event.gatekeepers.each { |p| expect(p).to be_gatekeeper }
    end
  end
end
