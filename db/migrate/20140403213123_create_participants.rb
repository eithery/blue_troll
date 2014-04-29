class CreateParticipants < ActiveRecord::Migration
  def up
    create_table :participants do |t|
      # User account info.
      t.belongs_to :user_account, null: false

      # Personal info.
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :middle_name
      t.integer :gender
      t.integer :age_category, null: false, default: 0
      t.integer :age
      t.date :born_on

      # Contacts and address.
      t.string :home_phone
      t.string :cell_phone
      t.string :email
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 10
      t.string :country

      # Ticket info.
      t.string :ticket_code

      # Misc fields.
      t.boolean :flagged, null: false, default: false
      t.text :notes, :text

      # Registration status.
      t.datetime :approved_at
      t.string :approved_by
      t.datetime :registered_at
      t.string :registered_by

      # Payment related fields.
      t.integer :payment_type
      t.datetime :payment_sent_at
      t.string :payment_sent_by
      t.string :payment_notes
      t.datetime :payment_received_at
      t.string :payment_received_by
      t.datetime :payment_confirmed_at
      t.string :payment_confirmed_by

      # Modification status.
      t.string :created_by
      t.string :updated_by
      t.timestamps
    end

    devs = [
      { crew_id: 29, user_account_id: 1, last_name: 'Protsenko', first_name: 'Michael' }
    ]

    crew_leads = [
      { user_account_id: 2, last_name: 'Shaykevich', first_name: 'Alex' },
      { user_account_id: 3, last_name: 'Shaykevich', first_name: 'Alex' },
      { user_account_id: 4, last_name: 'Pogorelsky', first_name: 'Yanina' },
      { user_account_id: 5, last_name: 'Zaverukha', first_name: 'Ilya' },
      { user_account_id: 6, last_name: 'Hamon', first_name: 'Roman' },
      { user_account_id: 7, last_name: 'Serebrenik', first_name: 'Boris' },
      { user_account_id: 8, last_name: 'Tuchina', first_name: 'Irina' },
      { user_account_id: 9, last_name: 'Polyakov', first_name: 'Alex' },
      { user_account_id: 10, last_name: 'Belyaev', first_name: 'Alexandr' },
      { user_account_id: 11, last_name: 'Dricker', first_name: 'Ilya' },
      { user_account_id: 12, last_name: 'Brandis', first_name: 'Margarita' },
      { user_account_id: 13, last_name: 'Gudgarts', first_name: 'Igor' },
      { user_account_id: 14, last_name: 'Akhmetov', first_name: 'Marina' },
      { user_account_id: 15, last_name: 'Grinberg', first_name: 'Anna' },
      { user_account_id: 16, last_name: 'Kazakov', first_name: 'Viktor' },
      { user_account_id: 17, last_name: 'Talalaev', first_name: 'Dmitriy' },
      { user_account_id: 18, last_name: 'Kosulin', first_name: 'Vlad' },
      { user_account_id: 19, last_name: 'Palitsky', first_name: 'Gennady' },
      { user_account_id: 20, last_name: 'Eidelstein', first_name: 'Victoria' },
      { user_account_id: 21, last_name: 'Lev', first_name: 'Yuri' },
      { user_account_id: 22, last_name: 'Yeliseyev', first_name: 'Rita' },
      { user_account_id: 23, last_name: 'Aks', first_name: 'Irina' },
      { user_account_id: 24, last_name: 'Pliner', first_name: 'Julia' },
      { user_account_id: 25, last_name: 'Khazak', first_name: 'Vladimir' },
      { user_account_id: 26, last_name: 'Zaks', first_name: 'Alex' },
      { user_account_id: 27, last_name: 'Mikaloff', first_name: 'Oleg' },
      { user_account_id: 28, last_name: 'Stolov', first_name: 'Andrei' },
      { user_account_id: 29, last_name: 'Karpova', first_name: 'Kate' },
      { user_account_id: 30, last_name: 'Rapoport', first_name: 'Lev' },
      { user_account_id: 31, last_name: 'Mashkovich', first_name: 'Inna' },
      { user_account_id: 32, last_name: 'Grapp', first_name: 'Igor' }
    ]

    crew_leads.each do |lead|
      lead[:approved_at] = Time.now
      lead[:approved_by] = 'admin'
      lead[:created_by] = 'admin'
      lead[:updated_by] = 'admin'
    end

    Participant.create!(devs + crew_leads)
  end


  def down
    drop_table :participants
  end
end
