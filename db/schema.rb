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

ActiveRecord::Schema.define(version: 20130918193218) do

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

  create_table "events", force: true do |t|
    t.string   "name",                         null: false
    t.text     "description"
    t.string   "event_type",  default: "slet", null: false
    t.integer  "lead_id"
    t.date     "from",                         null: false
    t.date     "to",                           null: false
    t.string   "location",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.integer  "crew_id",                                        null: false
    t.integer  "user_account_id",                                null: false
    t.string   "last_name",                                      null: false
    t.string   "first_name",                                     null: false
    t.string   "middle_name"
    t.integer  "gender"
    t.integer  "age_category",                   default: 0,     null: false
    t.date     "born_on"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "email"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state",                limit: 2
    t.string   "zip",                  limit: 5
    t.string   "country"
    t.string   "ticket_code"
    t.datetime "approved_at"
    t.string   "approved_by"
    t.datetime "payment_sent_at"
    t.string   "payment_sent_by"
    t.string   "payment_notes"
    t.datetime "payment_confirmed_at"
    t.string   "payment_confirmed_by"
    t.datetime "registered_at"
    t.string   "registered_by"
    t.boolean  "flagged",                        default: false, null: false
    t.boolean  "bool",                           default: false, null: false
    t.text     "notes"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_accounts", force: true do |t|
    t.string   "login",                           null: false
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "remember_token",                  null: false
    t.boolean  "active",          default: false, null: false
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_accounts", ["email"], name: "index_user_accounts_on_email", unique: true, using: :btree
  add_index "user_accounts", ["login"], name: "index_user_accounts_on_login", unique: true, using: :btree
  add_index "user_accounts", ["remember_token"], name: "index_user_accounts_on_remember_token", using: :btree

end
