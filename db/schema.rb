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

ActiveRecord::Schema.define(version: 20130912224234) do

  create_table "crews", force: true do |t|
    t.string   "name",                       null: false
    t.string   "native_name"
    t.text     "description"
    t.string   "commander"
    t.string   "location"
    t.string   "web_site"
    t.string   "email"
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_crews", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_participants", force: true do |t|
    t.integer  "event_id",           null: false
    t.integer  "participant_id",     null: false
    t.integer  "event_crew_id",      null: false
    t.integer  "event_ticket_id"
    t.string   "ticket_status",      null: false
    t.integer  "ticket_code"
    t.string   "reservation_number"
    t.string   "source"
    t.date     "registered_at"
    t.string   "registered_by"
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
    t.integer  "crew_id"
    t.integer  "family_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "gender"
    t.date     "birth_date"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "email"
    t.integer  "address_id"
    t.string   "child"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
