class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_token, null: false
      t.boolean :active, null: false, default: false
      t.datetime :activated_at
      t.timestamps
    end

    add_index :user_accounts, :login, unique: true
    add_index :user_accounts, :email, unique: true
    add_index :user_accounts, :remember_token
  end
end
