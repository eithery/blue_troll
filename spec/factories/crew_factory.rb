# Eithery Lab, 2016.
# Defines factories for Crew model.

FactoryGirl.define do
  factory :crew do
    name { Faker::Team.name }
    native_name { Faker::Team.name }
    event_type_id 1
    created_by 'test'
    updated_by 'test'
  end
end
