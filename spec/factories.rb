FactoryGirl.define do
  factory :user_account do
    login "jsmith"
    email "jsmith@gmail.com"
    email_confirmation "jsmith@gmail.com"
    password "secret"
    password_confirmation "secret"
  end
end
