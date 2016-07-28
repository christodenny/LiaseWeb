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

ActiveRecord::Schema.define(version: 20160116230605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.integer "team_id"
    t.integer "ppl_id"
    t.string  "phone_number"
    t.boolean "ppl_type"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "place"
    t.string   "name"
    t.decimal  "latitude",    precision: 9, scale: 6
    t.decimal  "longitude",   precision: 9, scale: 6
    t.text     "description"
  end

  create_table "people", force: :cascade do |t|
    t.string  "name"
    t.integer "team_id"
    t.string  "token"
  end

  create_table "people_events", force: :cascade do |t|
    t.integer "ppl_id"
    t.integer "event_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "contacts", "people", column: "ppl_id", name: "fk_contacts_people"
  add_foreign_key "contacts", "teams", name: "fk_contacts_teams"
  add_foreign_key "people", "teams", name: "fk_people_teams"
  add_foreign_key "people_events", "events", name: "fk_ppl_events_events"
  add_foreign_key "people_events", "people", column: "ppl_id", name: "fk_ppl_events_people"
end
