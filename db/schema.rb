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

ActiveRecord::Schema.define(version: 20160215210729) do

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

  create_table "events", force: :cascade do |t|
    t.string   "name",        null: false
    t.date     "started_on"
    t.date     "finished_on"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "created_by",  null: false
    t.string   "updated_by",  null: false
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "crew_id"
    t.string   "login",                                     null: false
    t.string   "email",                                     null: false
    t.string   "password_digest",                           null: false
    t.string   "remember_digest"
    t.boolean  "crew_lead",                 default: false, null: false
    t.boolean  "financier",                 default: false, null: false
    t.boolean  "gatekeeper",                default: false, null: false
    t.boolean  "admin",                     default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_expired_at"
    t.boolean  "active",                    default: false, null: false
    t.string   "activation_token"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "created_by",                                null: false
    t.string   "updated_by",                                null: false
    t.index ["activation_token"], name: "index_user_accounts_on_activation_token"
    t.index ["crew_id"], name: "index_user_accounts_on_crew_id"
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["login"], name: "index_user_accounts_on_login", unique: true
    t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token"
  end

end
