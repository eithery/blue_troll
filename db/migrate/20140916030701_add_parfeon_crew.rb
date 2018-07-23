class AddParfeonCrew < ActiveRecord::Migration[5.2]
  def up
    crew = Crew.create!(name: 'Parfeon', native_name: 'Парфеон')

    email = 'parfilko@gmail.com'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'vparfilko', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)
  end


  def down
    user = UserAccount.find_by_login('vparfilko')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
