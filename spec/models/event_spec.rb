# Eithery Lab, 2016.
# Event model specs.

require 'rails_helper'

describe Event do
  subject(:event) { FactoryGirl.build :event }
  let(:event_with_crews) { FactoryGirl.create :event, :with_crews }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has a required unique name'
  it_behaves_like 'it has timestamps'

  it { should respond_to :started_on, :finished_on }
  it { should respond_to :address }
  it { should respond_to :notes }
  it { should respond_to :event_type }
  it { should respond_to :crews, :participants }
  it { should respond_to :participant_by_ticket }
  it { should respond_to :crew_leads, :financiers, :gatekeepers }
  it { should respond_to :crew_lead_emails, :financier_emails }
  it { should respond_to :statistics }

  it { should validate_presence_of :started_on }
  it { should validate_presence_of :finished_on }
  it { should validate_presence_of :address }
  it { should validate_length_of(:address).is_at_most 255 }

  it { should belong_to :event_type }
  it { should have_db_index :event_type_id }
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
    include_context 'prepared event'

    it { expect(event).to have(5).participants }
    it { expect(Event.new).to have(:no).participants }
  end


  describe '#participant_by_ticket' do
  end


  describe '#crew_leads' do
  end


  describe '#crew_lead_emails' do
  end


  describe '#financiers' do
  end


  describe '#financier_emails' do
  end


  describe '#gatekeepers' do
  end


  describe '#statistics' do
  end
end
