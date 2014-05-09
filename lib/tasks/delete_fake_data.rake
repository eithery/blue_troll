namespace :db do
  desc "Deletes fake data records"
  task delete_fake_data: :environment do
    crew = Crew.find_by_name('Konserva Lovers')
    unless crew.nil?
      crew.user_accounts.each { |user| user.destroy }
      crew.destroy
    end

    puts "Fake data records have been deleted."
  end
end
