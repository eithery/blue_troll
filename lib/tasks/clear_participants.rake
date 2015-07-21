namespace :db do
  namespace :backup do

    desc "Saves all participants in backup tables"
    task participants: :environment do
      SQL = "select * into participants_bak from participants"
      ActiveRecord::Base.connection.execute(SQL)
    end
    
    desc "Saves all user accounts in backup tables"
    task user_accounts: :environment do
      SQL = "select * into uer_accounts_bak from user_accounts"
      ActiveRecord::Base.connection.execute(SQL)
    end
  end
end
