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

    desc "Deletes dummy crews"
    task clear: :environment do
      crew = Crew.find_by_name('Mad Hamsters')
      crew.destroy unless crew.nil?
      puts "Dummy crew has been deleted."
    end
  end
end
