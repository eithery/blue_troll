# Eithery Lab, 2016.
# Provides RSpec shared contexts.

require 'rails_helper'

shared_context 'upcoming event' do
  let(:persons) do
    Array.new(7) do
      user = FactoryGirl.build :user_account
      FactoryGirl.build :participant, user_account: user
    end
  end

  let(:crews) do
    Array.new(2) { FactoryGirl.build :crew }
  end

  let(:event) do
    event = FactoryGirl.build(:event)
    crew = FactoryGirl.build(:event_crew, event: event, prototype: crews[0])
    other_crew = FactoryGirl.build(:event_crew, event: event, prototype: crews[1])

    participant = FactoryGirl.build(:event_participant, person: persons[0], crew: crew)
    other_participant = FactoryGirl.build(:event_participant, person: persons[1], crew: crew)
    crew_lead = FactoryGirl.build(:crew_lead, person: persons[2], crew: crew)
    crew.participants << [participant, other_participant, crew_lead]

    other_crew_lead = FactoryGirl.build(:crew_lead, person: persons[3], crew: other_crew)
    financier = FactoryGirl.build(:financier, person: persons[4], crew: other_crew)

    other_crew.participants << [other_crew_lead, financier]
    event.crews << [crew, other_crew]
    event.save!
    event
  end

  let(:other_event) do
    event = FactoryGirl.build(:event)
    crew = FactoryGirl.build(:event_crew, event: event, prototype: crews[0])

    other_event_crew_lead = FactoryGirl.build :crew_lead, person: persons[5], crew: crew
    financier = FactoryGirl.build :financier, person: persons[6], crew: crew

    crew.participants << [other_event_crew_lead, financier]
    event.crews << crew
    event.save!
    event
  end

  let(:crew) { event.crews.first }
  let(:other_crew) { event.crews.last }
  let(:other_event_crew) { other_event.crews.first }

  let(:crew_lead) { crew.leads.first }
  let(:other_crew_lead) { other_crew.leads.first }
  let(:other_event_crew_lead) { other_event_crew.leads.first }

  let(:financier) { event.financiers.first }
  let(:other_financier) { other_event.financiers.first }

  let(:participant) { crew.participants.first }
  let(:other_participant) { crew.participants.second }
end