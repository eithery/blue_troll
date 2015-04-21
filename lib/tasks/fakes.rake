namespace :db do
  namespace :fakes do
    desc "Creates fake crew for test purposes"
    task create: :environment do
      crew = Crew.find_by_name('Mad Hamsters')
      if crew.nil?
        Crew.create!(name: 'Mad Hamsters', native_name: 'Бешеные Хомяки')
        puts "Fake crew 'Mad Hamsters' has been created."
      end
    end


    desc "Creates fake admin user account"
    task admin: :environment do
      crew = Crew.find_by_name('Mad Hamsters') || Crew.find_by_name('Guests')
      admin = UserAccount.find_by_login('michaelpro')
      if admin.nil?
        UserAccount.create!(login: 'michaelpro', email: 'bluetrolley.app@gmail.com', email_confirmation: 'bluetrolley.app@gmail.com',
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


    desc "Configures fake financier user account"
    task financier: :environment do
      admin = UserAccount.find_by_login('michaelpro')
      unless admin.nil?
        admin.admin = false
        admin.crew_lead = false
        admin.dev = false
        admin.financier = true
        admin.save!(validate: false)
      end
      puts "Superadmin account has been set as financier."
    end


    desc "Configures fake crew lead user account"
    task crew_lead: :environment do
      admin = UserAccount.find_by_login('michaelpro')
      unless admin.nil?
        admin.admin = false
        admin.crew_lead = true
        admin.dev = false
        admin.financier = false
        admin.save!(validate: false)
      end
      puts "Superadmin account has been set as crew lead."
    end


    desc "Deletes fakes"
    task clear: :environment do
      user = UserAccount.find_by_login('michaelpro')
      user.destroy unless user.nil?
      puts "Superadmin account has been deleted."

      crew = Crew.find_by_name('Mad Hamsters')
      crew.destroy unless crew.nil?
      puts "Dummy crew has been deleted."
    end
  end
end
