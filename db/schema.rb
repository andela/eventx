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

ActiveRecord::Schema.define(version: 20150921101748) do

  create_table "attendees", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "uniq_id"
    t.integer  "amount"
    t.string   "txn_id"
    t.integer  "payment_status",     default: 0, null: false
    t.integer  "user_tickets_count", default: 0
  end

  add_index "bookings", ["event_id"], name: "index_bookings_on_event_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "banner"
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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "venue"
    t.integer  "event_template_id"
    t.string   "map_url"
    t.integer  "event_manager_id"
  end

  create_table "ticket_purchases", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "ticket_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ticket_purchases", ["attendee_id"], name: "index_ticket_purchases_on_attendee_id"
  add_index "ticket_purchases", ["ticket_id"], name: "index_ticket_purchases_on_ticket_id"

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
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "booking_id"
  end

  add_index "user_tickets", ["booking_id"], name: "index_user_tickets_on_booking_id"
  add_index "user_tickets", ["ticket_type_id"], name: "index_user_tickets_on_ticket_type_id"

  create_table "users", force: :cascade do |t|
    t.integer  "role",                   default: 0
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
