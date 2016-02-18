# Eithery Lab, 2016.
# Defines factories for EventParticipant model.

FactoryGirl.define do
  factory :event_participant do
    association :participant
    created_by 'test'
    updated_by 'test'

    after(:build) do |ep|
      ep.crew = build(:event_crew, crew: ep.participant.crew)
    end
  end
end
