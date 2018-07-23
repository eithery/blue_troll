class AddBooksClubCrew < ActiveRecord::Migration[5.2]
  def up
    crew = Crew.create!(name: 'Books Club', native_name: 'Книжный Клуб')

    email = 'pavel.vaynshtok@gmail.com'
    password = SecureRandom.urlsafe_base64
    user = UserAccount.create!(login: 'pvaynshtok', email: email, email_confirmation: email, password: password, password_confirmation: password,
      crew: crew, crew_lead: true, active: true, activated_at: Time.now)

    Participant.create!(last_name: 'Vaynshtok', first_name: 'Pavel', user_account: user, primary: true, approved_at: Time.now,
      approved_by: 'admin', payment_confirmed_at: Time.now, payment_confirmed_by: 'ryeliseyev', payment_notes: "Paid as crew lead.",
      created_by: 'admin', updated_by: 'admin')
  end


  def down
    user = UserAccount.find_by_login('pvaynshtok')
    crew = user.crew
    user.destroy
    crew.destroy
  end
end
