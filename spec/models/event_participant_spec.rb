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
