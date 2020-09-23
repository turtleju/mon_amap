# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_23_204626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amap_producers", force: :cascade do |t|
    t.bigint "amap_id", null: false
    t.bigint "producer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amap_id"], name: "index_amap_producers_on_amap_id"
    t.index ["producer_id"], name: "index_amap_producers_on_producer_id"
  end

  create_table "amaps", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "legal_address"
    t.string "distribution_address"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "manager_id"
    t.index ["manager_id"], name: "index_amaps_on_manager_id"
  end

  create_table "delivery_days", force: :cascade do |t|
    t.bigint "period_day_id", null: false
    t.bigint "formula_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["formula_id"], name: "index_delivery_days_on_formula_id"
    t.index ["period_day_id"], name: "index_delivery_days_on_period_day_id"
  end

  create_table "formulas", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.text "description"
    t.bigint "producer_id", null: false
    t.bigint "period_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["period_id"], name: "index_formulas_on_period_id"
    t.index ["producer_id"], name: "index_formulas_on_producer_id"
  end

  create_table "period_days", force: :cascade do |t|
    t.bigint "period_id", null: false
    t.date "day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["period_id"], name: "index_period_days_on_period_id"
  end

  create_table "periods", force: :cascade do |t|
    t.date "start_on"
    t.date "finish_on"
    t.bigint "amap_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amap_id"], name: "index_periods_on_amap_id"
  end

  create_table "producers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "company_name"
    t.string "phone"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_producers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_producers_on_reset_password_token", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "subscribable_type", null: false
    t.bigint "subscribable_id", null: false
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable_type_and_subscribable_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "amap_producers", "amaps"
  add_foreign_key "amap_producers", "producers"
  add_foreign_key "amaps", "users", column: "manager_id"
  add_foreign_key "delivery_days", "formulas"
  add_foreign_key "delivery_days", "period_days"
  add_foreign_key "formulas", "periods"
  add_foreign_key "formulas", "producers"
  add_foreign_key "period_days", "periods"
  add_foreign_key "periods", "amaps"
  add_foreign_key "subscriptions", "users"
end
