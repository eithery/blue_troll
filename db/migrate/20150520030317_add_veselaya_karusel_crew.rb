class AddVeselayaKaruselCrew < ActiveRecord::Migration[5.2]
  def up
    crew = Crew.create!(name: 'Veselaya Karusel', native_name: 'Веселая Карусель')

    email = 'diana_amerika@mail.ru'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'dshults', email: email, email_confirmation: email, password: password,
      password_confirmation: password, crew: crew, crew_lead: true, active: true, activated_at: Time.now)

    Participant.create!(last_name: 'Shults', first_name: 'Diana', user_account: user, primary: true, approved_at: Time.now,
      approved_by: 'admin', payment_confirmed_at: Time.now, payment_confirmed_by: 'ashaykevish', payment_notes: "Paid as crew lead.",
      created_by: 'admin', updated_by: 'admin')
  end


  def down
    user = UserAccount.find_by_login('dshults')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
