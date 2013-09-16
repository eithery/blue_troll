class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      # Main Participant info.
      t.integer :crew_id, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :middle_name
      t.integer :gender
      t.date :birth_date
      t.string :home_phone
      t.string :cell_phone
      t.string :email
      t.text :address
      t.integer :child, null: false, default: 0
      t.boolean :active, null: false, default: true

      # Ticket related info.
      t.string :ticket_code
      t.boolean :paid, null: false, default: false
      t.boolean :sent, null: false, default: false
      t.string :sent_by

      # Fields used for integration with Igor's DB.
      t.integer :import_id
      t.string :reservation_number

      # Registration fields.
      t.datetime :registered_at
      t.string :registered_by

      t.timestamps
    end
  end
end
