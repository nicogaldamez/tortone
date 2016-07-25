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

ActiveRecord::Schema.define(version: 20160722141909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "file_uid"
    t.string   "file_name"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attachments", ["vehicle_id"], name: "index_attachments_on_vehicle_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buyer_interests", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "brand_id"
    t.integer  "vehicle_model_id"
    t.integer  "year",             null: false
    t.integer  "max_kilometers"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "buyer_interests", ["brand_id"], name: "index_buyer_interests_on_brand_id", using: :btree
  add_index "buyer_interests", ["buyer_id"], name: "index_buyer_interests_on_buyer_id", using: :btree
  add_index "buyer_interests", ["vehicle_model_id"], name: "index_buyer_interests_on_vehicle_model_id", using: :btree

  create_table "buyers", force: :cascade do |t|
    t.string   "first_name",                                           null: false
    t.string   "last_name"
    t.string   "phones",                                               null: false
    t.string   "email"
    t.boolean  "is_hdi",                               default: false
    t.boolean  "has_automatic_transmission",           default: false
    t.integer  "min_price_in_cents",         limit: 8, default: 0
    t.integer  "max_price_in_cents",         limit: 8
    t.text     "notes"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name",  null: false
    t.string   "last_name",   null: false
    t.string   "dni"
    t.string   "phones"
    t.string   "address"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", using: :btree
  add_index "customers", ["first_name"], name: "index_customers_on_first_name", using: :btree
  add_index "customers", ["last_name"], name: "index_customers_on_last_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "vehicle_models", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicle_models", ["brand_id"], name: "index_vehicle_models_on_brand_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "vehicle_model_id"
    t.integer  "version_id"
    t.integer  "customer_id"
    t.integer  "kilometers"
    t.string   "color"
    t.text     "details"
    t.integer  "cost_in_cents",              limit: 8
    t.integer  "price_in_cents",             limit: 8
    t.date     "entered_on"
    t.date     "sold_on"
    t.boolean  "is_exchange",                          default: false
    t.boolean  "is_consignment",                       default: false
    t.boolean  "is_financed",                          default: false
    t.integer  "minimum_advance_in_cents",   limit: 8
    t.integer  "transfer_amount_in_cents",   limit: 8
    t.string   "plate"
    t.integer  "year"
    t.string   "motor_number"
    t.string   "chassis_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_owner",                             default: false
    t.boolean  "has_automatic_transmission",           default: false
    t.boolean  "is_hdi",                               default: false
  end

  add_index "vehicles", ["brand_id"], name: "index_vehicles_on_brand_id", using: :btree
  add_index "vehicles", ["customer_id"], name: "index_vehicles_on_customer_id", using: :btree
  add_index "vehicles", ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id", using: :btree
  add_index "vehicles", ["version_id"], name: "index_vehicles_on_version_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vehicle_model_id"
  end

  add_index "versions", ["vehicle_model_id"], name: "index_versions_on_vehicle_model_id", using: :btree

  add_foreign_key "attachments", "vehicles"
  add_foreign_key "buyer_interests", "brands"
  add_foreign_key "buyer_interests", "buyers"
  add_foreign_key "buyer_interests", "vehicle_models"
  add_foreign_key "vehicle_models", "brands"
  add_foreign_key "vehicles", "brands"
  add_foreign_key "vehicles", "customers"
  add_foreign_key "vehicles", "vehicle_models"
  add_foreign_key "vehicles", "versions"
  add_foreign_key "versions", "vehicle_models"
end
