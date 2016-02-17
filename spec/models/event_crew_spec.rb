# Eithery Lab, 2016.
# EventCrew model specs.

require 'rails_helper'

describe EventCrew do
  subject { FactoryGirl.build :event_crew }

  it_behaves_like 'a valid domain model'
  it_behaves_like 'it has timestamps'

  it { should respond_to :crew, :event }
  it { should respond_to :notes }

  it { should validate_presence_of :event }
  it { should validate_presence_of :crew }

  it { should have_db_index :event_id }
  it { should have_db_index :crew_id }

  it { should belong_to(:event).inverse_of :crews }
  it { should belong_to :crew }
end
