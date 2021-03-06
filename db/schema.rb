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

ActiveRecord::Schema.define(version: 2021_06_25_174231) do

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "text"
    t.string "title"
    t.integer "stars"
    t.integer "user_id", null: false
    t.integer "tea_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tea_id"], name: "index_reviews_on_tea_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "type"
    t.string "flavor"
    t.string "description"
    t.integer "brand_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_teas_on_brand_id"
    t.index ["user_id"], name: "index_teas_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "reviews", "teas"
  add_foreign_key "reviews", "users"
  add_foreign_key "teas", "brands"
  add_foreign_key "teas", "users"
end
