namespace :db do
  desc "Sets up admin user account as financier"
  task financier: :environment do
    admin = UserAccount.find_by_login('admin')
    unless admin.nil?
      admin.admin = false
      admin.crew_lead = false
      admin.dev = false
      admin.financier = true
      admin.save!(validate: false)
    end

    puts "Superadmin account has been set as financier."
  end
end
