class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_token, null: false
      t.boolean :crew_lead, null: false, default: false
      t.boolean :financier, null: false, default: false
      t.boolean :gatekeeper, null: false, default: false
      t.boolean :admin, null: false, default: false
      t.boolean :dev, null: false, default: false

      t.boolean :active, null: false, default: false
      t.string :activation_code
      t.datetime :activated_at
      t.timestamps
    end

    add_index :user_accounts, :login, unique: true
    add_index :user_accounts, :email, unique: true
    add_index :user_accounts, :remember_token
  end


  UserAccount.create!(login: 'dev',
    email: 'michael.protsenko@gmail.com', email_confirmation: 'michael.protsenko@gmail.com',
    password: 'maryika', password_confirmation: 'maryika', active: true, dev: true, gatekeeper: true,
    financier: true, admin: true)
end
