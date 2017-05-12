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

ActiveRecord::Schema.define(version: 20170511173246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "customers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "reservoir_id"
  end

  create_table "flow_sensors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "pin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "device_id"
    t.index ["pin", "device_id"], name: "index_flow_sensors_on_pin_and_device_id", unique: true
  end

  create_table "flow_sensors_data", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "consumption_per_minute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "flow_sensor_id"
  end

  create_table "level_sensors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "pin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "ruler_id"
    t.decimal "volume"
    t.integer "sequence"
    t.index ["sequence", "ruler_id"], name: "index_level_sensors_on_sequence_and_ruler_id", unique: true
  end

  create_table "level_sensors_data", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "switched_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "level_sensor_id"
    t.uuid "ruler_data_id"
    t.index ["ruler_data_id", "level_sensor_id"], name: "index_level_sensors_data_on_ruler_data_id_and_level_sensor_id", unique: true
  end

  create_table "reservoir_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "customer_id"
  end

  create_table "reservoirs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "customer_id"
    t.uuid "reservoir_group_id"
  end

  create_table "roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rulers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "device_id"
  end

  create_table "rulers_data", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "ruler_id"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.uuid "customer_id"
    t.uuid "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "devices", "reservoirs"
  add_foreign_key "flow_sensors", "devices"
  add_foreign_key "flow_sensors_data", "flow_sensors"
  add_foreign_key "level_sensors", "rulers"
  add_foreign_key "level_sensors_data", "level_sensors"
  add_foreign_key "level_sensors_data", "rulers_data"
  add_foreign_key "reservoir_groups", "customers"
  add_foreign_key "reservoirs", "customers"
  add_foreign_key "reservoirs", "reservoir_groups"
  add_foreign_key "rulers", "devices"
  add_foreign_key "rulers_data", "rulers"
  add_foreign_key "users", "customers"
  add_foreign_key "users", "roles"
end
