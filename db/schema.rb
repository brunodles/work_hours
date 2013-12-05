# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(:version => 20131205181738) do

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "time_works", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "description"
    t.boolean  "is_open",     :default => true
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "time_works", ["project_id"], :name => "index_time_works_on_project_id"
  add_index "time_works", ["user_id"], :name => "index_time_works_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "password"
    t.string   "email"
    t.integer  "access_number",          :default => 0
    t.datetime "last_access_at"
    t.string   "last_access_ip"
    t.string   "password_recovery_hash"
    t.datetime "password_recovery_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

end
