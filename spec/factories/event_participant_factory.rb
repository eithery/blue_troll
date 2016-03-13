# Eithery Lab, 2016.
# Defines factories for EventParticipant model.

FactoryGirl.define do
  factory :event_participant do
    association :person, factory: :participant
    created_by 'test'
    updated_by 'test'

    factory :crew_lead do
      crew_lead true
    end

    factory :financier do
      financier true
    end

    trait :with_event_crew do
      after(:build) do |ep|
        ep.crew = build(:event_crew)
      end
    end
  end
end
