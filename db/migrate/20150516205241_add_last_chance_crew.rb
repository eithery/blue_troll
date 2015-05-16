class AddLastChanceCrew < ActiveRecord::Migration
  def up
    crew = Crew.create!(name: 'Last Chance', native_name: 'Последний Шанс')

    email = 'bluetrolleyclub@yahoo.com'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'btclub', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)
  end


  def down
    user = UserAccount.find_by_login('btclub')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
