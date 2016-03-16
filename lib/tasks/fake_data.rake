namespace :db do
  desc "Fills database populating sample data"
  task fake_data: :environment do
    crew = Crew.create!(name: 'Konserva Lovers', native_name: 'Любители Консервов')

    100.times do |n|
      email = Faker::Internet.email
      password = Faker::Internet.password
      address = "#{Faker::Address.street_address} #{Faker::Address.secondary_address} #{Faker::Address.city}, #{Faker::Address.state_abbr}"

      user = UserAccount.create!(
        login: Faker::Internet.user_name,
        email: email,
        email_confirmation: email,
        password: password,
        password_confirmation: password,
        crew: crew,
        active: true,
        activated_at: Time.zone.now
      )

      Participant.create!(
        user_account: user,
        last_name: Faker::Name.last_name,
        first_name: Faker::Name.first_name,
        age_category: n % 5 == 0 ? 2 : 0,
        age: n % 5 == 0 ? 3 : nil,
        home_phone: Faker::PhoneNumber.cell_phone,
        cell_phone: Faker::PhoneNumber.cell_phone,
        email: Faker::Internet.email,
        address: address,
        approved_at: Time.zone.now,
        approved_by: 'admin',
        created_by: 'admin',
        updated_by: 'admin'
      )
    end

    puts "Fake data records have been created."
  end
end
