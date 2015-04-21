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

ActiveRecord::Schema.define(version: 20150421014203) do

  create_table "crews", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "native_name",                null: false
    t.boolean  "active",      default: true, null: false
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "crews", ["name"], name: "index_crews_on_name", unique: true
  add_index "crews", ["native_name"], name: "index_crews_on_native_name", unique: true

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "emails", force: :cascade do |t|
    t.string   "from_address",                       null: false
    t.string   "reply_to_address"
    t.string   "subject"
    t.text     "to_address"
    t.text     "cc_address"
    t.text     "bcc_address"
    t.text     "content",          limit: 104857600
    t.datetime "sent_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "user_account_id",                      null: false
    t.string   "last_name",                            null: false
    t.string   "first_name",                           null: false
    t.string   "middle_name"
    t.integer  "gender"
    t.integer  "age_category",         default: 0,     null: false
    t.integer  "age"
    t.date     "born_on"
    t.boolean  "primary"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "email"
    t.text     "address"
    t.string   "ticket_code"
    t.boolean  "flagged",              default: false, null: false
    t.text     "notes"
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
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "participants", ["ticket_code"], name: "index_participants_on_ticket_code", unique: true

  create_table "user_accounts", force: :cascade do |t|
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
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "user_accounts", ["activation_token"], name: "index_user_accounts_on_activation_token"
  add_index "user_accounts", ["email"], name: "index_user_accounts_on_email", unique: true
  add_index "user_accounts", ["login"], name: "index_user_accounts_on_login", unique: true
  add_index "user_accounts", ["remember_token"], name: "index_user_accounts_on_remember_token", unique: true
  add_index "user_accounts", ["reset_password_token"], name: "index_user_accounts_on_reset_password_token"

end
