class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.belongs_to :crew

      t.string :login, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.boolean :crew_lead, null: false, default: false
      t.boolean :financier, null: false, default: false
      t.boolean :gatekeeper, null: false, default: false
      t.boolean :admin, null: false, default: false
      t.boolean :dev, null: false, default: false

      t.string :remember_token, null: false
      t.string :reset_password_token
      t.datetime :reset_password_expired_at
      t.boolean :active, null: false, default: false
      t.string :activation_token
      t.string :activation_code
      t.datetime :activated_at
      t.timestamps null: false
    end

    add_index :user_accounts, :login, unique: true
    add_index :user_accounts, :email, unique: true
    add_index :user_accounts, :remember_token, unique: true
    add_index :user_accounts, :reset_password_token
    add_index :user_accounts, :activation_token
  end
end
