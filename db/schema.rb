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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120605144636) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "replay_id",                 :null => false
    t.text     "text",                      :null => false
    t.integer  "user_id",                   :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "rating",     :default => 0, :null => false
  end

  create_table "replays", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "protoss"
    t.boolean  "zerg"
    t.boolean  "terran"
    t.string   "players"
    t.string   "league"
    t.integer  "category_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "replay_file"
    t.integer  "user_id"
    t.string   "status",         :default => "new", :null => false
    t.datetime "expires_at",                        :null => false
    t.float    "average_rating", :default => 0.0,   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "role",                 :default => "member", :null => false
    t.boolean  "active",               :default => true,     :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
  end

end
