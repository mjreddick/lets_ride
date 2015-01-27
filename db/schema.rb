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

ActiveRecord::Schema.define(version: 20150127054353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "eventful_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "request_id"
  end

  add_index "notifications", ["request_id"], name: "index_notifications_on_request_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "requests", force: true do |t|
    t.string   "user_address"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ride_id"
    t.integer  "user_id"
  end

  add_index "requests", ["ride_id"], name: "index_requests_on_ride_id", using: :btree
  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "rides", force: true do |t|
    t.integer  "num_seats"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "rides", ["event_id"], name: "index_rides_on_event_id", using: :btree

  create_table "userrides", force: true do |t|
    t.string   "user_address"
    t.boolean  "is_driver"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "ride_id"
  end

  add_index "userrides", ["ride_id"], name: "index_userrides_on_ride_id", using: :btree
  add_index "userrides", ["user_id"], name: "index_userrides_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
