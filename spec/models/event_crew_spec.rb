# Eithery Lab, 2016.
# EventCrew model specs.

require 'rails_helper'

describe EventCrew do
  subject(:crew) { FactoryGirl.build :event_crew }
  let(:populated_crew) { FactoryGirl.build :event_crew, :with_participants }
  let(:email) { email = 'test@gmail.com' }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'
  it_behaves_like 'it provides statistics'

  it { should respond_to :prototype, :event }
  it { should respond_to :notes }
  it { should respond_to :name, :to_file_name }
  it { should respond_to :leads, :lead_emails, :emails }

  it { should have_db_index :event_id }
  it { should have_db_index :crew_id }

  it { should belong_to(:event).inverse_of :crews }
  it { should belong_to(:prototype).class_name(Crew).with_foreign_key :crew_id }


  describe 'validation' do
    context 'when the crew prototype is not defined' do
      before { crew.prototype = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :prototype }
    end

    context 'when the event is not specified' do
      before { crew.event = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :event }
    end
  end


  describe '#name' do
    it 'returns the crew prototype name' do
      expect(crew.name).to eq crew.prototype.name
    end
  end


  describe '#to_file_name' do
    before { crew.prototype.name = 'Wolf Tails' }

    it 'provides a file name for the crew' do
      expect(crew.to_file_name).to eq 'wolf_tails'
    end
  end


  describe '#leads' do
    it 'returns all crew leads of the crew' do
      expect(populated_crew).to have(6).participants
      expect(populated_crew.leads).to have(2).persons
    end
  end


  describe '#emails' do
    it 'returns all crew participants emails' do
      expect(populated_crew).to have(6).emails
    end

    it 'does not contain duplicates' do
      populated_crew.participants[0..2].each { |p| p.person.email = email }
      expect(populated_crew).to have(4).emails
      expect(populated_crew.emails).to include email
    end
  end


  describe '#lead_emails' do
    it 'returns all crew leads emails' do
      expect(populated_crew).to have(2).lead_emails
    end

    it 'does not contain duplicates' do
      populated_crew.leads.each { |lead| lead.person.email = email }
      expect(populated_crew).to have(1).lead_emails
      expect(populated_crew.lead_emails).to include email
    end
  end
end
