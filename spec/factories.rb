FactoryGirl.define do
  factory :active_user, class: UserAccount do
    login "jsmith"
    email "jsmith@gmail.com"
    email_confirmation "jsmith@gmail.com"
    password "secret"
    password_confirmation "secret"
    active true
  end

  factory :inactive_user, class: UserAccount do
    login "cdarwin"
    email "cdarwin@gmail.com"
    email_confirmation "cdarwin@gmail.com"
    password "secret"
    password_confirmation "secret"
    active false
  end
end
