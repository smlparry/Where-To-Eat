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

ActiveRecord::Schema.define(version: 20150331064427) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "categories", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "category"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email"
    t.string   "os"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "category_id"
    t.string   "item"
    t.integer  "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "inaccuracy"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "open_hours"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "rating"
    t.string   "uri"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "has_items"
    t.string   "contact_email"
    t.string   "contact_name"
    t.boolean  "active"
    t.integer  "subscription_amount"
    t.string   "cuisine"
  end

end
