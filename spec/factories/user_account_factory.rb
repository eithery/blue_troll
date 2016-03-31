# Eithery Lab, 2016.
# Defines factories for UserAccount model.

FactoryGirl.define do
  factory :user_account do
    login { Faker::Lorem.characters(10) }
    email { Faker::Internet.email }
    email_confirmation { email }
    password 'supersecret'
    password_confirmation 'supersecret'
    activated true
    activated_at Time.zone.now
    created_by 'test'
    updated_by 'test'

    factory :admin do
      admin true
    end

    factory :rita do
      financier true
    end

    trait :with_participants do
      after(:build) do |user|
        user.participants << [
          build(:participant, user_account: user),
          build(:participant, user_account: user),
          build(:participant, user_account: user)
        ]
      end
    end
  end
end
