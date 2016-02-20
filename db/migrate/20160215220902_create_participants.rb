# Eithery Lab, 2016.
# Participant model migration.
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

      t.string :home_phone
      t.string :cell_phone
      t.string :email, index: true
      t.text :address
      t.text :notes

      t.full_timestamps

      t.foreign_key :user_accounts
    end
  end
end
