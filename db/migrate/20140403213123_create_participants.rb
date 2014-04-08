class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      # Crew and user account info.
      t.belongs_to :crew, null: false
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
      t.string :zip, limit: 5
      t.string :country

      # Ticket info.
      t.string :ticket_code

      # Misc fields.
      t.boolean :primary, null: false, default: true
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
  end
end
