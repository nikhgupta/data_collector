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

ActiveRecord::Schema.define(version: 20151108191539) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "aggregates", force: :cascade do |t|
    t.integer  "sensor_id",     limit: 4
    t.time     "period_start"
    t.time     "period_end"
    t.string   "period_length", limit: 255
    t.string   "total",         limit: 255
    t.string   "count",         limit: 255
    t.string   "mean",          limit: 255
    t.string   "std_dev",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "aggregates", ["sensor_id"], name: "index_aggregates_on_sensor_id", using: :btree

  create_table "sensor_data", force: :cascade do |t|
    t.integer  "sensor_id",  limit: 4
    t.time     "data_time"
    t.string   "data_value", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sensor_data", ["sensor_id"], name: "index_sensor_data_on_sensor_id", using: :btree

  create_table "sensors", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "uuid",       limit: 255
    t.string   "format",     limit: 255
    t.string   "length",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sensors", ["user_id"], name: "index_sensors_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "",    null: false
    t.string   "uuid",                   limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
    t.boolean  "fake",                   limit: 1,   default: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "aggregates", "sensors"
  add_foreign_key "sensor_data", "sensors"
  add_foreign_key "sensors", "users"
end
