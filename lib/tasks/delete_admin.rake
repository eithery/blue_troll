namespace :db do
  desc "Deletes superadmin user account"
  task delete_admin: :environment do
    user = UserAccount.find_by_login('admin')
    user.destroy unless user.nil?

    puts "Superadmin account has been deleted."
  end
end
