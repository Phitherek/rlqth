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

ActiveRecord::Schema.define(version: 20150717200149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_locations", force: :cascade do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "locator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_queries", force: :cascade do |t|
    t.integer  "remote_user_id"
    t.integer  "location_id"
    t.string   "location_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ip_locations", force: :cascade do |t|
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "locator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pure_locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "locator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remote_sessions", force: :cascade do |t|
    t.string   "token"
    t.datetime "token_expires"
    t.string   "refresh_token"
    t.integer  "remote_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "remote_users", force: :cascade do |t|
    t.string   "callsign"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reverse_locations", force: :cascade do |t|
    t.string   "locator"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "reverse_address"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
