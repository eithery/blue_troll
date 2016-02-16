# Eithery Lab, 2016.
# Defines factories for UserAccount model.

FactoryGirl.define do
  factory :user_account do
    login 'gwen'
    email 'gwen@gmail.com'
    email_confirmation 'gwen@gmail.com'
    password 'secret'
    password_confirmation 'secret'
    activated true
    activated_at Time.zone.now
    created_by 'test'
    updated_by 'test'
  end
end
