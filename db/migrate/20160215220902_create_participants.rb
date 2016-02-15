# Eithery Lab, 2016.
# Blue Trolley Participant model migration.
# Creates participants data table.

require_relative 'helpers/table_definition'

class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.belongs_to :user_account, null: false, index: true

      t.string :last_name, null: false, index: true
      t.string :first_name, null: false
      t.string :middle_name
      t.integer :gender
      t.integer :age_category, null: false, default: 0
      t.integer :age
      t.date :born_on
      t.boolean :primary

      t.string :home_phone
      t.string :cell_phone
      t.string :email, index: true
      t.text :address

      t.string :ticket_code

      t.boolean :flagged, null: false, default: false
      t.text :notes

      t.datetime :approved_at
      t.string :approved_by
      t.datetime :registered_at
      t.string :registered_by

      t.integer :payment_type
      t.datetime :payment_sent_at
      t.string :payment_sent_by
      t.string :payment_notes
      t.datetime :payment_received_at
      t.string :payment_received_by
      t.datetime :payment_confirmed_at
      t.string :payment_confirmed_by

      t.full_timestamps

      t.index :ticket_code, unique: true

      t.foreign_key :user_accounts
    end
  end
end
