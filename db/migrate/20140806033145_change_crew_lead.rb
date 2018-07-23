class ChangeCrewLead < ActiveRecord::Migration[5.2]
  def up
#    prev_lead = UserAccount.find_by_login('abelyaev')
#    prev_lead.crew_lead = false
#    prev_lead.save(validate: false)

#    email = 'vadim@belyayev.com'
#    password = SecureRandom.urlsafe_base64
#    new_lead = UserAccount.create!(login: 'vbelyaev', email: email, email_confirmation: email, password: password,
#      password_confirmation: password, crew: prev_lead.crew, crew_lead: true, active: true, activated_at: Time.now)

#    p = Participant.where(last_name: 'Belyaev', first_name: 'Vadim').to_a.first
#    p.primary = true
#    p.user_account = new_lead
#    p.save
  end


  def down
  end
end
