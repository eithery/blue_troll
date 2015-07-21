namespace :db do
  namespace :backup do

    desc "Saves all participants in backup tables"
    task participants: :environment do
      SQL = "select * into participants_bak from participants"
      ActiveRecord::Base.connection.execute(SQL)
    end
    
    desc "Saves all user accounts in backup tables"
    task user_accounts: :environment do
      SQL = "select * into user_accounts_bak from user_accounts"
      ActiveRecord::Base.connection.execute(SQL)
    end
  end


  namespace :participants do

    task clean: :environment do
      Participant.all do |p|
        p.destroy! unless p.paid?
      end
    end

    task reset: :environment do
      Participant.all do |p|
        p.flagged = nil
        p.notes = nil
        p.approved_at = nil
        p.approved_by = nil
        p.registered_at = nil
        p.registered_by = nil
        p.payment_type = nil
        p.payment_sent_at = nil
        p.payment_sent_by = nil
        p.payment_received_at = nil
        p.payment_received_by = nil
        p.payment_confirmed_at = nil
        p.payment_confirmed_by = nil
        p.ticket_code = SecureRandom.hex[0, 10]
      end
    end
  end
end
