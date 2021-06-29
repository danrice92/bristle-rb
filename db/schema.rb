# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_29_194142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "careers", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_careers_on_title", unique: true
  end

  create_table "employer_locations", force: :cascade do |t|
    t.bigint "employer_id"
    t.bigint "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_employer_locations_on_employer_id"
    t.index ["location_id"], name: "index_employer_locations_on_location_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_employers_on_name"
  end

  create_table "employment_locations", force: :cascade do |t|
    t.bigint "employment_id"
    t.bigint "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employment_id"], name: "index_employment_locations_on_employment_id"
    t.index ["location_id"], name: "index_employment_locations_on_location_id"
  end

  create_table "employments", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.decimal "starting_pay"
    t.decimal "ending_pay"
    t.bigint "user_id"
    t.bigint "employer_id"
    t.bigint "user_career_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "primary_location_id"
    t.index ["employer_id"], name: "index_employments_on_employer_id"
    t.index ["title"], name: "index_employments_on_title"
    t.index ["user_career_id"], name: "index_employments_on_user_career_id"
    t.index ["user_id"], name: "index_employments_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address"], name: "index_locations_on_address"
    t.index ["city"], name: "index_locations_on_city"
    t.index ["country"], name: "index_locations_on_country"
    t.index ["state"], name: "index_locations_on_state"
    t.index ["zipcode"], name: "index_locations_on_zipcode"
  end

  create_table "user_careers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "career_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["career_id"], name: "index_user_careers_on_career_id"
    t.index ["user_id"], name: "index_user_careers_on_user_id"
  end

  create_table "user_locations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_user_locations_on_location_id"
    t.index ["user_id"], name: "index_user_locations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "auth_token"
    t.boolean "email_verified", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email_verified"], name: "index_users_on_email_verified"
  end

  add_foreign_key "employments", "employers"
  add_foreign_key "employments", "user_careers"
  add_foreign_key "employments", "users"
  add_foreign_key "user_careers", "careers"
  add_foreign_key "user_careers", "users"
end
