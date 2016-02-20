# Eithery Lab, 2016.
# Crew model specs.

require 'rails_helper'

describe Crew do
  subject(:crew) { FactoryGirl.build :crew }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has a required unique name'
  it_behaves_like 'it has timestamps'

  it { should respond_to :native_name }
  it { should respond_to :active? }
  it { should respond_to :location, :notes }
  it { should respond_to :event_type }
  it { should respond_to :full_name }

  it { should have_db_index(:native_name).unique }
  it { should have_db_index(:event_type_id) }

  it { should validate_presence_of :native_name }
  it { should validate_uniqueness_of(:native_name).case_insensitive }
  it { should validate_length_of(:native_name).is_at_most 255 }
  it { should validate_length_of(:location).is_at_most 255 }

  it { should belong_to :event_type }


  describe 'validation' do
    context 'when the crew event type is not defined' do
      before { crew.event_type = nil }

      it { is_expected.to_not be_valid }
      it { is_expected.to have(1).error_on :event_type }
    end
  end


  describe '#full_name' do
    it 'returns concatenation of a crew name and native name' do
      expect(crew.full_name).to eq "#{crew.name} (#{crew.native_name})"
    end
  end
end
