namespace :db do
  desc "Creates superadmin user account"
  task admin: :environment do
    UserAccount.create!(login: 'admin', email: 'bluetrolley2014@gmail.com', email_confirmation: 'bluetrolley2014@gmail.com',
      password: 'mandozebra', password_confirmation: 'mandozebra', crew: Crew.last, active: true, crew_lead: true, dev: true,
      gatekeeper: true, financier: true, admin: true)

    puts "Superadmin account has been created."
  end
end
