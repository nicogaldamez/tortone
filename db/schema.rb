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

ActiveRecord::Schema.define(version: 20160701121213) do

  create_table "customers", force: :cascade do |t|
    t.string   "first_name",  limit: 255,   null: false
    t.string   "last_name",   limit: 255,   null: false
    t.string   "dni",         limit: 255
    t.string   "phones",      limit: 255
    t.string   "address",     limit: 255
    t.string   "email",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", using: :btree
  add_index "customers", ["first_name"], name: "index_customers_on_first_name", using: :btree
  add_index "customers", ["last_name"], name: "index_customers_on_last_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 255, null: false
    t.string   "crypted_password", limit: 255
    t.string   "salt",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end