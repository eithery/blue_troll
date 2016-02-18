# Eithery Lab, 2016.
# Defines factories for Participant model.

FactoryGirl.define do
  factory :participant do
    association :user_account, factory: :user_with_crew

    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    created_by 'test'
    updated_by 'test'
  end
end
