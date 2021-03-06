class AddGoldenKeyCrew < ActiveRecord::Migration[5.2]
  def up
    crew = Crew.create!(name: 'Golden Key', native_name: 'Золотой Ключик')

    email = 'yellowyuli@gmail.com'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'yshpilman', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)
  end


  def down
    user = UserAccount.find_by_login('yshpilman')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
