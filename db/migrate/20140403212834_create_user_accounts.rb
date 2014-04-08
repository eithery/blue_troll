class CreateUserAccounts < ActiveRecord::Migration
  def up
    create_table :user_accounts do |t|
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
      t.boolean :active, null: false, default: false
      t.string :activation_token
      t.string :activation_code
      t.datetime :activated_at
      t.timestamps
    end

    add_index :user_accounts, :login, unique: true
    add_index :user_accounts, :email, unique: true
    add_index :user_accounts, :remember_token


    UserAccount.create!(login: 'sa',
      email: 'michael.protsenko@gmail.com', email_confirmation: 'michael.protsenko@gmail.com',
      password: 'secret', password_confirmation: 'secret', active: true, dev: true, gatekeeper: true,
      financier: true, admin: true)
  end


  def down
    drop_table :user_accounts
  end
end
