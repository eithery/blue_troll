namespace :db do
  desc "Fills database populating sample data"
  task populate: :environment do
    crew = Crew.find_by_name('Guests')

    100.times do |n|
      email = Faker::Internet.email
      password = Faker::Internet.password

      user = UserAccount.create!(
        login: Faker::Internet.user_name,
        email: email,
        email_confirmation: email,
        password: password,
        password_confirmation: password,
        active: true,
        activated_at: Time.now
      )

      Participant.create!(
        user_account: user,
        crew: crew,
        last_name: Faker::Name.last_name,
        first_name: Faker::Name.first_name,
        age_category: n % 5 == 0 ? 2 : 0,
        age: n % 5 == 0 ? 3 : nil,
        home_phone: Faker::PhoneNumber.cell_phone,
        cell_phone: Faker::PhoneNumber.cell_phone,
        email: Faker::Internet.email,
        address_line_1: Faker::Address.street_address,
        address_line_2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip: Faker::Address.zip_code,
        country: Faker::Address.country,
        approved_at: Time.now,
        approved_by: 'admin',
        created_by: 'admin',
        updated_by: 'admin'
      )
    end
  end
end
