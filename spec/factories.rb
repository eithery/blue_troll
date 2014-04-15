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

  factory :crew_lead, class: UserAccount do
    login "boss"
    email "boss@bossmail.com"
    email_confirmation "boss@bossmail.com"
    password "secret"
    password_confirmation "secret"
    active true
    crew_lead true
  end

  factory :financier, class: UserAccount do
    login "rita"
    email "rita@gmail.com"
    email_confirmation "rita@gmail.com"
    password "secret"
    password_confirmation "secret"
    active true
    financier true
  end

  factory :admin, class: UserAccount do
    login "admin"
    email "btadmin@gmail.com"
    email_confirmation "btadmin@gmail.com"
    password "secret"
    password_confirmation "secret"
    active true
    admin true
  end

  factory :gatekeeper, class: UserAccount do
    login "gate"
    email "gate@gmail.com"
    email_confirmation "gate@gmail.com"
    password "secret"
    password_confirmation "secret"
    active true
    gatekeeper true
  end


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
end
