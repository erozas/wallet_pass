# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_05_041520) do
  create_table "events", force: :cascade do |t|
    t.integer "organizer_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "venue_name"
    t.string "venue_address"
    t.decimal "venue_lat", precision: 10, scale: 6
    t.decimal "venue_lng", precision: 10, scale: 6
    t.datetime "event_date"
    t.datetime "doors_open_at"
    t.integer "ticket_price_cents"
    t.integer "max_capacity"
    t.integer "tickets_sold_count", default: 0
    t.string "category", default: "active"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_date"], name: "index_events_on_event_date"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
    t.index ["status"], name: "index_events_on_status"
    t.index ["venue_lat", "venue_lng"], name: "index_events_on_venue_lat_and_venue_lng"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "company_name", null: false
    t.string "phone"
    t.text "description"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_organizers_on_email", unique: true
  end

  add_foreign_key "events", "organizers"
end
