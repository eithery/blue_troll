namespace :db do
  desc "Sets up admin user account as crew lead"
  task crew_lead: :environment do
    admin = UserAccount.find_by_login('admin')
    unless admin.nil?
      admin.admin = false
      admin.crew_lead = true
      admin.dev = false
      admin.financier = false
      admin.save!(validate: false)
    end

    puts "Superadmin account has been set as crew lead."
  end
end
