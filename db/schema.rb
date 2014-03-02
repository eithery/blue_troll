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

ActiveRecord::Schema.define(version: 20130925213101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crews", force: true do |t|
    t.string   "name",                       null: false
    t.string   "native_name",                null: false
    t.text     "description"
    t.string   "captain"
    t.string   "location"
    t.string   "web_site"
    t.string   "email"
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "crew_id",                            null: false
    t.string   "last_name",                          null: false
    t.string   "first_name",                         null: false
    t.string   "middle_name"
    t.integer  "gender"
    t.date     "birth_date"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "email"
    t.text     "address"
    t.integer  "child",              default: 0,     null: false
    t.boolean  "active",             default: true,  null: false
    t.string   "ticket_code"
    t.boolean  "paid",               default: false, null: false
    t.boolean  "sent",               default: false, null: false
    t.string   "sent_by"
    t.integer  "import_id"
    t.string   "reservation_number"
    t.datetime "registered_at"
    t.string   "registered_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flagged",            default: false, null: false
    t.text     "notes"
  end

  create_table "user_accounts", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "remember_token",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_accounts", ["email"], name: "index_user_accounts_on_email", unique: true, using: :btree
  add_index "user_accounts", ["remember_token"], name: "index_user_accounts_on_remember_token", using: :btree

end
