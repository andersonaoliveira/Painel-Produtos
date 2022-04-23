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

ActiveRecord::Schema.define(version: 2022_02_10_202532) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "periods", force: :cascade do |t|
    t.string "name"
    t.integer "months"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["months"], name: "index_periods_on_months", unique: true
    t.index ["name"], name: "index_periods_on_name", unique: true
    t.index ["slug"], name: "index_periods_on_slug", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "details"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_group_id", null: false
    t.string "slug"
    t.index ["product_group_id"], name: "index_plans_on_product_group_id"
    t.index ["slug"], name: "index_plans_on_slug", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.integer "period_id", null: false
    t.integer "plan_id", null: false
    t.decimal "value", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "registered_by"
    t.index ["period_id"], name: "index_prices_on_period_id"
    t.index ["plan_id"], name: "index_prices_on_plan_id"
  end

  create_table "product_groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "icon_file_name"
    t.string "icon_content_type"
    t.integer "icon_file_size"
    t.datetime "icon_updated_at"
    t.string "slug"
    t.index ["key"], name: "index_product_groups_on_key", unique: true
    t.index ["name"], name: "index_product_groups_on_name", unique: true
    t.index ["slug"], name: "index_product_groups_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "customer"
    t.integer "plan_id", null: false
    t.integer "status", default: 0
    t.string "product_code"
    t.integer "server_id", null: false
    t.index ["plan_id"], name: "index_products_on_plan_id"
    t.index ["server_id"], name: "index_products_on_server_id"
  end

  create_table "servers", force: :cascade do |t|
    t.integer "capacity"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "plan_id", default: 0, null: false
    t.index ["plan_id"], name: "index_servers_on_plan_id"
    t.index ["slug"], name: "index_servers_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "administrator", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "plans", "product_groups"
  add_foreign_key "prices", "periods"
  add_foreign_key "prices", "plans"
  add_foreign_key "products", "plans"
  add_foreign_key "products", "servers"
  add_foreign_key "servers", "plans"
end
