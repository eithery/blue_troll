class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_token, null: false
      t.timestamps
    end

    add_index :user_accounts, :email, unique: true
    add_index :user_accounts, :remember_token
  end
end
