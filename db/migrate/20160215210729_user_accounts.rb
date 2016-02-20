# Eithery Lab, 2016.
# UserAccount model migration.
# Creates user_accounts data table.

require_relative 'helpers/table_definition'

class UserAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accounts do |t|
      t.string :login, null: false
      t.string :email, null: false

      t.string :password_digest, null: false
      t.string :remember_digest
      t.string :activation_digest, null: false
      t.string :reset_digest

      t.datetime :activated_at
      t.datetime :reset_sent_at

      t.boolean :admin, null: false, default: false
      t.boolean :activated, null: false, default: false

      t.full_timestamps

      t.index :login, unique: true
      t.index :email, unique: true
    end
  end
end
