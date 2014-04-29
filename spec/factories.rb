FactoryGirl.define do
  # Crews.
  factory :crew do
    name "Guests"
    native_name "Гости слета"
  end

  factory :spies, class: Crew do
    name "Enemy spies"
    native_name "Вражеские шпионы"
  end

  factory :fix_crew, class: Crew do
    name "Mr Fix Friends"
    native_name "Друганы Мистера Фикса"
  end

  factory :inactive_crew, class: Crew do
    name "Black List"
    native_name "Черный список"
    active false
  end


  # User accounts.
  factory :user, class: UserAccount do
    sequence(:login) { |n| "btuser#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:email_confirmation) { |n| "person_#{n}@example.com" }
    password "secret"
    password_confirmation "secret"
    active true
    association :crew, factory: :crew

    factory :crew_lead do
      crew_lead true
    end

    factory :admin do
      admin true
    end

    factory :financier do
      financier true
    end

    factory :gatekeeper do
      gatekeeper true
    end
  end

  factory :active_user, class: UserAccount do
    login "jsmith"
    email "jsmith@gmail.com"
    email_confirmation "jsmith@gmail.com"
    password "secret"
    password_confirmation "secret"
    active true
    association :crew, factory: :crew
  end

  factory :inactive_user, class: UserAccount do
    login "cdarwin"
    email "cdarwin@gmail.com"
    email_confirmation "cdarwin@gmail.com"
    password "secret"
    password_confirmation "secret"
    active false
  end


  # Participants.
  factory :gwen, class: Participant do
    association :user_account, factory: :user
    last_name 'Hvostan'
    first_name 'Gwen'
    age_category 2
    age 3
  end

  factory :fix, class: Participant do
    association :user_account, factory: :crew_lead
    last_name 'Fix'
    first_name 'Mister'
  end
end
