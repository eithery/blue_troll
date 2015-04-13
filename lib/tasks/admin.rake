namespace :db do
  desc "Creates superadmin user account"
  task admin: :environment do
    crew = Crew.find_by_name('Guests')
    admin = UserAccount.find_by_login('admin')
    if admin.nil?
      UserAccount.create!(login: 'admin', email: 'bluetrolley2015@gmail.com', email_confirmation: 'bluetrolley2015@gmail.com',
        password: 'mandozebra', password_confirmation: 'mandozebra', crew: crew, active: true, crew_lead: false, dev: false,
        gatekeeper: false, financier: false, admin: true)

      puts "Superadmin account has been created."
    else
      admin.admin = true
      admin.crew_lead = false
      admin.dev = false
      admin.financier = false
      admin.save!(validate: false)

      puts "Superadmin account has been set as admin."
    end
  end
end
