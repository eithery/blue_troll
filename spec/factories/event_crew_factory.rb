# Eithery Lab, 2016.
# Defines factories for EventCrew model.

FactoryGirl.define do
  factory :event_crew do
    association :event
    association :prototype, factory: :crew
    created_by 'test'
    updated_by 'test'
  end
end
