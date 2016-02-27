# Eithery Lab, 2016.
# Defines factories for EventCrew model.

FactoryGirl.define do
  factory :event_crew do
    association :event
    association :prototype, factory: :crew
    created_by 'test'
    updated_by 'test'
  end

  trait :with_participants do
    after(:build) do |crew|
      crew.participants << Array.new(2) { FactoryGirl.build :crew_lead }
      crew.participants << Array.new(4) { FactoryGirl.build :event_participant }
    end
  end
end
