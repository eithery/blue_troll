# Eithery Lab, 2016.
# Blue Trolley UserAccount model migration.
# Creates user_accounts data table.

require_relative 'helpers/table_definition'

class UserAccount < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accounts do |t|
      t.belongs_to :crew, index: true

      t.string :login, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_digest

      t.boolean :crew_lead, null: false, default: false
      t.boolean :financier, null: false, default: false
      t.boolean :gatekeeper, null: false, default: false
      t.boolean :admin, null: false, default: false

      t.string :reset_password_token, index: true
      t.datetime :reset_password_expired_at
      t.boolean :active, null: false, default: false
      t.string :activation_token, index: true
      t.string :activation_code
      t.datetime :activated_at

      t.full_timestamps

      t.index :login, unique: true
      t.index :email, unique: true

      t.foreign_key :crews
    end
  end
end
