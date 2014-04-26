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
      t.datetime :reset_password_expired_at
      t.boolean :active, null: false, default: false
      t.string :activation_token
      t.string :activation_code
      t.datetime :activated_at
      t.timestamps
    end

    add_index :user_accounts, :login, unique: true
    add_index :user_accounts, :email, unique: true
    add_index :user_accounts, :remember_token, unique: true
    add_index :user_accounts, :reset_password_token
    add_index :user_accounts, :activation_token


    devs = [{ login: 'dev', email: 'michael.protsenko@gmail.com', email_confirmation: 'michael.protsenko@gmail.com',
      password: 'secret', password_confirmation: 'secret', active: true, dev: true, gatekeeper: true, financier: true,
      admin: true }]

    crew_leads = [
      { login: 'alexshayk', email: 'alexshayk@yahoo.com', password: generate, admin: true, financier: true },
      { login: 'ashaykevich', email: 'alexshayk@gmail.com', password: generate },
      { login: 'ypogorelsky', email: 'ypogorelsky@hotmail.com', password: generate },
      { login: 'izaverukha', email: 'ilyazaver@gmail.com', password: generate },
      { login: 'rhamon', email: 'romanhamon3@yahoo.com', password: generate },
      { login: 'bserebrenik', email: 'bserebrenik@gmail.com', password: generate },
      { login: 'ituchina', email: 'iratuchin@netscape.net', password: generate },
      { login: 'apolyakov', email: 'alekspolyakov@yahoo.com', password: generate },
      { login: 'abelyaev', email: 'alexander@belyayev.com', password: generate },
      { login: 'idricker', email: 'ilya.dricker@gmail.com', password: generate },
      { login: 'mbrandis', email: 'leto4you@yahoo.com', password: generate },
      { login: 'igudgarts', email: 'morpeh92@yahoo.com', password: generate },
      { login: 'makhmetov', email: 'marina.mashka@gmail.com', password: generate },
      { login: 'agrinberg', email: 'annagrin@yahoo.com', password: generate },
      { login: 'vkazakov', email: 'victorkazak@gmail.com', password: generate },
      { login: 'dtalalaev', email: 'fatcatd@gmail.com', password: generate },
      { login: 'vkosulin', email: 'kosulin@yahoo.com', password: generate },
      { login: 'gpalitsky', email: 'superblin@gmail.com', password: generate },
      { login: 'veidelstein', email: 'vishinka@yahoo.com', password: generate },
      { login: 'ylev', email: 'yuri.j.lev@gmail.com', password: generate },
      { login: 'ryeliseyev', email: 'ryeliseyev@gmail.com', password: generate, financier: true },
      { login: 'iaks', email: 'irina.akc@gmail.com', password: generate },
      { login: 'jpliner', email: 'jplinerinteriors@gmail.com', password: generate },
      { login: 'vkhazak', email: 'vladimirkhazak@yahoo.com', password: generate },
      { login: 'azaks', email: 'demzak@yahoo.com', password: generate },
      { login: 'omikaloff', email: 'omikaloff@yahoo.com', password: generate },
      { login: 'astolov', email: 'andrei_stolov@yahoo.com', password: generate },
      { login: 'kkarpova', email: 'katekarpova@yahoo.com', password: generate },
      { login: 'lrapoport', email: 'lvrapoport@gmail.com', password: generate },
      { login: 'imashkovich', email: 'inna.mashkovich@power.alstom.com', password: generate },
      { login: 'igrapp', email: 'igrapp@gmail.com', password: generate }
    ]

    crew_leads.each do |lead|
      lead[:email_confirmation] = lead[:email]
      lead[:password_confirmation] = lead[:password]
      lead[:crew_lead] = true
      lead[:active] = true
      lead[:activated_at] = Time.now
    end

    UserAccount.create!(devs + crew_leads)
  end


  def down
    drop_table :user_accounts
  end


private
  def generate
    SecureRandom.urlsafe_base64
  end
end
