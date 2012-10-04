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

ActiveRecord::Schema.define(:version => 20121004044038) do

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "access_token"
    t.integer  "user_id",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "type"
  end

  create_table "admins", :force => true do |t|
    t.string   "username",                            :null => false
    t.string   "crypted_password",                    :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "password_salt",                       :null => false
    t.string   "persistence_token",                   :null => false
    t.string   "perishable_token",                    :null => false
    t.boolean  "active",            :default => true
  end

  create_table "albums", :force => true do |t|
    t.integer  "facebook_aid", :null => false
    t.integer  "user_id",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "identifier",                     :null => false
    t.string   "thumbnail"
    t.string   "full"
    t.integer  "account_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "description"
    t.string   "photo_type"
    t.boolean  "deleted",     :default => false
    t.boolean  "highlighted", :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",      :null => false
    t.string   "user_type",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "nickname"
  end

end
