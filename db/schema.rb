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

ActiveRecord::Schema.define(version: 20160614142249) do

  create_table "attendees", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "uniq_id"
    t.integer  "amount"
    t.string   "txn_id"
    t.integer  "payment_status",     default: 0,     null: false
    t.integer  "user_tickets_count", default: 0
    t.boolean  "refund_requested",   default: false
    t.datetime "time_requested"
    t.boolean  "granted",            default: false
    t.integer  "granted_by"
    t.datetime "time_granted"
    t.string   "reason"
  end

  add_index "bookings", ["event_id"], name: "index_bookings_on_event_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "banner"
    t.integer  "manager_profile_id", default: 0
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "event_staffs", force: :cascade do |t|
    t.integer  "role"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_staffs", ["event_id"], name: "index_event_staffs_on_event_id"
  add_index "event_staffs", ["user_id", "event_id"], name: "index_event_staffs_on_user_id_and_event_id", unique: true
  add_index "event_staffs", ["user_id"], name: "index_event_staffs_on_user_id"

  create_table "event_templates", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "image"
    t.integer  "theme_id"
    t.integer  "category_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "venue"
    t.integer  "event_template_id"
    t.string   "map_url"
    t.integer  "manager_profile_id"
    t.boolean  "enabled",            default: true
  end

  add_index "events", ["manager_profile_id"], name: "index_events_on_manager_profile_id"

  create_table "highlights", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "image"
    t.string   "image_title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "day"
  end

  add_index "highlights", ["event_id"], name: "index_highlights_on_event_id"

  create_table "manager_profiles", force: :cascade do |t|
    t.string   "user_id"
    t.string   "subdomain"
    t.string   "company_name"
    t.string   "company_mail"
    t.string   "company_phone"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "domain"
  end

  create_table "remits", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "total_amount"
    t.string   "status",       default: "requested"
    t.integer  "event_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "body"
    t.integer  "rating",     default: 3
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reviews", ["event_id"], name: "index_reviews_on_event_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "sponsors", force: :cascade do |t|
    t.string   "name"
    t.string   "logo"
    t.string   "url"
    t.text     "summary"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "level"
  end

  add_index "sponsors", ["event_id"], name: "index_sponsors_on_event_id"

  create_table "ticket_types", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "event_id"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "user_tickets", force: :cascade do |t|
    t.integer  "ticket_type_id"
    t.string   "ticket_number"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "booking_id"
    t.boolean  "is_used",        default: false
    t.datetime "time_used"
    t.integer  "scanned_by"
  end

  add_index "user_tickets", ["booking_id"], name: "index_user_tickets_on_booking_id"
  add_index "user_tickets", ["ticket_type_id"], name: "index_user_tickets_on_ticket_type_id"

  create_table "users", force: :cascade do |t|
    t.integer  "status",                 default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "profile_url"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "oauth_token"
    t.datetime "oauth_token_expires_at"
  end

end
