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
