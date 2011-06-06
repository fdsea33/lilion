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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110606123016) do

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "salt"
    t.string   "hashed_password"
    t.boolean  "receive_notifications"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "petitions", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "subtitle"
    t.text     "intro"
    t.text     "body"
    t.string   "sender"
    t.boolean  "published"
    t.boolean  "active"
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signatures", :force => true do |t|
    t.integer  "petition_id"
    t.string   "nature"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "language"
    t.text     "infos"
    t.string   "ip_address"
    t.string   "hashed_key"
    t.string   "checked_at"
    t.boolean  "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
