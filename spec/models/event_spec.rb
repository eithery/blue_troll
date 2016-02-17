# Eithery Lab, 2016.
# Event model specs.

require 'rails_helper'

describe Event do
  subject { FactoryGirl.build :event }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has a required unique name'
  it_behaves_like 'it has timestamps'

  it { should respond_to :started_on, :finished_on }
  it { should respond_to :address }
  it { should respond_to :notes }
  it { should respond_to :event_type }

  it { should validate_presence_of :started_on }
  it { should validate_presence_of :finished_on }
  it { should validate_presence_of :address }
  it { should validate_presence_of :event_type }
  it { should validate_length_of(:address).is_at_most 255 }

  it { should belong_to :event_type }
  it { should have_db_index :event_type_id }
end
