# Eithery Lab, 2016.
# Defines factories for Participant model.

FactoryGirl.define do
  factory :participant do
    association :user_account

    last_name 'Smith'
    first_name 'John'
    created_by 'test'
    updated_by 'test'
  end
end
