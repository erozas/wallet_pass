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

ActiveRecord::Schema[8.0].define(version: 2025_08_12_002536) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.string "slug"
    t.text "sections"
    t.integer "seats_per_section", default: 50
    t.index ["event_date"], name: "index_events_on_event_date"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
    t.index ["status"], name: "index_events_on_status"
    t.index ["venue_lat", "venue_lng"], name: "index_events_on_venue_lat_and_venue_lng"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
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

  create_table "passkit_devices", force: :cascade do |t|
    t.string "identifier"
    t.string "push_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passkit_logs", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passkit_passes", force: :cascade do |t|
    t.string "generator_type"
    t.string "klass"
    t.bigint "generator_id"
    t.string "serial_number"
    t.string "authentication_token"
    t.json "data"
    t.integer "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["generator_type", "generator_id"], name: "index_passkit_passes_on_generator"
  end

  create_table "passkit_registrations", force: :cascade do |t|
    t.integer "passkit_pass_id"
    t.integer "passkit_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["passkit_device_id"], name: "index_passkit_registrations_on_passkit_device_id"
    t.index ["passkit_pass_id"], name: "index_passkit_registrations_on_passkit_pass_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.string "ticket_number"
    t.integer "status", default: 0
    t.datetime "purchased_at"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.string "section"
    t.string "seat"
    t.datetime "checked_in_at"
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
    t.index ["uuid"], name: "index_tickets_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "events", "organizers"
  add_foreign_key "sessions", "users"
  add_foreign_key "tickets", "events"
  add_foreign_key "tickets", "users"
end
