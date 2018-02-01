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

ActiveRecord::Schema.define(version: 20180201162508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", id: :serial, force: :cascade do |t|
    t.string "attachinariable_type"
    t.integer "attachinariable_id"
    t.string "scope"
    t.string "public_id"
    t.string "version"
    t.integer "width"
    t.integer "height"
    t.string "format"
    t.string "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "rating"
    t.string "comment"
    t.integer "host"
    t.bigint "plan_id"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_bookings_on_plan_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent"
    t.integer "kid_age"
    t.integer "jalous"
    t.integer "old_kid"
    t.string "name"
    t.string "email", default: "email@example.com"
    t.integer "get_out"
    t.integer "visit", default: 0
    t.integer "step", default: 0
    t.boolean "bordelais"
    t.integer "host"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preprofiles", force: :cascade do |t|
    t.string "address"
    t.integer "kids"
    t.string "mother_first_name"
    t.string "father_first_name"
    t.bigint "user_id"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "need1"
    t.integer "need2"
    t.integer "need3"
    t.integer "need4"
    t.integer "step"
    t.index ["user_id"], name: "index_preprofiles_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "address"
    t.integer "kids"
    t.string "comment"
    t.string "phone"
    t.string "mother_first_name"
    t.string "father_first_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "rating"
    t.integer "step"
    t.string "zip_code"
    t.string "city"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_wishes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "wish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_wishes_on_user_id"
    t.index ["wish_id"], name: "index_user_wishes_on_wish_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "validated"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
  end

  add_foreign_key "bookings", "plans"
  add_foreign_key "bookings", "users"
  add_foreign_key "preprofiles", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "user_wishes", "users"
  add_foreign_key "user_wishes", "wishes"
end
