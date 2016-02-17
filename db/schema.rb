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

ActiveRecord::Schema.define(version: 20160217180647) do

  create_table "crews", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "native_name",                null: false
    t.boolean  "active",      default: true, null: false
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "created_by",                 null: false
    t.string   "updated_by",                 null: false
    t.index ["name"], name: "index_crews_on_name", unique: true
    t.index ["native_name"], name: "index_crews_on_native_name", unique: true
  end

  create_table "event_crews", force: :cascade do |t|
    t.integer  "event_id",   null: false
    t.integer  "crew_id",    null: false
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "created_by", null: false
    t.string   "updated_by", null: false
    t.index ["crew_id"], name: "index_event_crews_on_crew_id"
    t.index ["event_id"], name: "index_event_crews_on_event_id"
  end

  create_table "event_participants", force: :cascade do |t|
    t.integer  "event_id",                             null: false
    t.integer  "participant_id",                       null: false
    t.string   "ticket_code"
    t.boolean  "crew_lead"
    t.boolean  "financier"
    t.boolean  "gatekeeper"
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
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "created_by",                           null: false
    t.string   "updated_by",                           null: false
    t.index ["event_id"], name: "index_event_participants_on_event_id"
    t.index ["participant_id"], name: "index_event_participants_on_participant_id"
    t.index ["ticket_code"], name: "index_event_participants_on_ticket_code", unique: true
  end

  create_table "event_types", force: :cascade do |t|
    t.string  "name",                                 null: false
    t.text    "description"
    t.boolean "enabled",               default: true, null: false
    t.integer "ordinal",     limit: 1
    t.index ["name"], name: "index_event_types_on_name", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer  "event_type_id", null: false
    t.string   "name",          null: false
    t.date     "started_on"
    t.date     "finished_on"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "created_by",    null: false
    t.string   "updated_by",    null: false
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "user_account_id",                 null: false
    t.string   "last_name",                       null: false
    t.string   "first_name",                      null: false
    t.string   "middle_name"
    t.integer  "gender"
    t.integer  "age_category",    default: 0,     null: false
    t.integer  "age"
    t.date     "born_on"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "email"
    t.text     "address"
    t.text     "notes"
    t.boolean  "crew_lead",       default: false, null: false
    t.boolean  "financier",       default: false, null: false
    t.boolean  "gatekeeper",      default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "created_by",                      null: false
    t.string   "updated_by",                      null: false
    t.index ["email"], name: "index_participants_on_email"
    t.index ["last_name"], name: "index_participants_on_last_name"
    t.index ["user_account_id"], name: "index_participants_on_user_account_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "crew_id"
    t.string   "login",                             null: false
    t.string   "email",                             null: false
    t.string   "password_digest",                   null: false
    t.string   "remember_digest"
    t.boolean  "admin",             default: false, null: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false, null: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "created_by",                        null: false
    t.string   "updated_by",                        null: false
    t.index ["activation_digest"], name: "index_user_accounts_on_activation_digest"
    t.index ["crew_id"], name: "index_user_accounts_on_crew_id"
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["login"], name: "index_user_accounts_on_login", unique: true
    t.index ["reset_digest"], name: "index_user_accounts_on_reset_digest"
  end

end
