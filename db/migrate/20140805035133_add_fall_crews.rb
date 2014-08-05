class AddFallCrews < ActiveRecord::Migration
  def up
    crew = Crew.create!(name: 'El-Tor-2', native_name: 'Эль Тор 2')

    email = 'kravchenko_eugene@yahoo.com'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'ekravchenko', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)

    crew = Crew.create!(name: 'Operatsia Yi', native_name: 'Операция Ы')

    email = 'yyefimov@comcast.net'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'yyefimov', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)
  end


  def down
    user = UserAccount.find_by_login('ekravchenko')
    crew = user.crew
    user.destroy
    crew.destroy

    user = UserAccount.find_by_login('yyefimov')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
