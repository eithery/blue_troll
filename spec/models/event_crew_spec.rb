# Eithery Lab, 2016.
# EventCrew model specs.

require 'rails_helper'

describe EventCrew do
  subject(:crew) { FactoryGirl.build :event_crew }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :prototype, :event }
  it { should respond_to :notes }
  it { should respond_to :name, :to_file_name }
  it { should respond_to :leads, :lead_emails, :emails, :statistics }

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
  end


  describe '#emails' do
  end


  describe '#lead_emails' do
  end


  describe '#statistics' do
  end
end
