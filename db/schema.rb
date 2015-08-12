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

ActiveRecord::Schema.define(version: 20150810090649) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "banner"
  end

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
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "venue"
    t.integer  "event_template_id"
    t.string   "map_url"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "event_id"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

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
