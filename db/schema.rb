# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140403213123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crews", force: true do |t|
    t.string   "name",                       null: false
    t.string   "native_name",                null: false
    t.boolean  "active",      default: true, null: false
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crews", ["name"], name: "index_crews_on_name", unique: true, using: :btree
  add_index "crews", ["native_name"], name: "index_crews_on_native_name", unique: true, using: :btree

  create_table "participants", force: true do |t|
    t.integer  "user_account_id",                      null: false
    t.string   "last_name",                            null: false
    t.string   "first_name",                           null: false
    t.string   "middle_name"
    t.integer  "gender"
    t.integer  "age_category",         default: 0,     null: false
    t.integer  "age"
    t.date     "born_on"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "email"
    t.text     "address"
    t.string   "ticket_code"
    t.boolean  "flagged",              default: false, null: false
    t.text     "notes"
    t.text     "text"
    t.datetime "approved_at"
    t.string   "approved_by"
    t.datetime "registered_at"
    t.string   "registered_by"
    t.integer  "payment_type"
    t.datetime "payment_sent_at"
    t.string   "payment_sent_by"
    t.string   "payment_notes"
    t.datetime "payment_received_at"
    t.string   "payment_received_by"
    t.datetime "payment_confirmed_at"
    t.string   "payment_confirmed_by"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_accounts", force: true do |t|
    t.integer  "crew_id"
    t.string   "login",                                     null: false
    t.string   "email",                                     null: false
    t.string   "password_digest",                           null: false
    t.boolean  "crew_lead",                 default: false, null: false
    t.boolean  "financier",                 default: false, null: false
    t.boolean  "gatekeeper",                default: false, null: false
    t.boolean  "admin",                     default: false, null: false
    t.boolean  "dev",                       default: false, null: false
    t.string   "remember_token",                            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_expired_at"
    t.boolean  "active",                    default: false, null: false
    t.string   "activation_token"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_accounts", ["activation_token"], name: "index_user_accounts_on_activation_token", using: :btree
  add_index "user_accounts", ["email"], name: "index_user_accounts_on_email", unique: true, using: :btree
  add_index "user_accounts", ["login"], name: "index_user_accounts_on_login", unique: true, using: :btree
  add_index "user_accounts", ["remember_token"], name: "index_user_accounts_on_remember_token", unique: true, using: :btree
  add_index "user_accounts", ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", using: :btree

end
