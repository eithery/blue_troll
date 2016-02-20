# Eithery Lab, 2016.
# Provides RSpec shared contexts.

require 'rails_helper'

shared_context 'prepared event' do
  let(:event) do
    event = FactoryGirl.create(:event)
    3.times do |n|
      crew = FactoryGirl.create(:crew)
      event.crews << FactoryGirl.create(:event_crew, event: event, prototype: crew)
    end

    user = FactoryGirl.create(:user_account)
    5.times do |n|
      participant = FactoryGirl.create(:participant, user_account: user)
      FactoryGirl.create(:event_participant, person: participant, crew: event.crews.first)
    end

    event.save!
    event
  end
end
