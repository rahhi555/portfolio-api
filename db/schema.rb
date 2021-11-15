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

ActiveRecord::Schema.define(version: 2021_11_14_135832) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_google_map", default: false, comment: "グーグルマップ使用フラグ"
    t.string "address", comment: "住所文字列"
    t.integer "heading", comment: "マップの回転度数。0~360を範囲とする"
    t.json "bounds", comment: "マップの表示範囲。typescriptのgoogle.maps.LatLngBoundsLiteralと同様"
    t.float "width"
    t.float "height"
    t.index ["plan_id", "name"], name: "index_maps_on_plan_id_and_name", unique: true
    t.index ["plan_id"], name: "index_maps_on_plan_id"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.bigint "role_id"
    t.boolean "accept", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_members_on_plan_id"
    t.index ["role_id"], name: "index_members_on_role_id"
    t.index ["user_id", "plan_id"], name: "index_members_on_user_id_and_plan_id", unique: true
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "published", default: false, null: false
    t.boolean "active", default: false, null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_roles_on_plan_id"
  end

  create_table "svgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "type"
    t.bigint "map_id", null: false
    t.float "x", null: false
    t.float "y", null: false
    t.string "fill", null: false
    t.string "stroke", null: false
    t.string "name", null: false
    t.integer "display_order", null: false
    t.float "width"
    t.float "height"
    t.integer "display_time"
    t.text "draw_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "todo_list_id"
    t.bigint "user_id"
    t.index ["map_id"], name: "index_svgs_on_map_id"
    t.index ["todo_list_id"], name: "index_svgs_on_todo_list_id"
    t.index ["type"], name: "index_svgs_on_type"
    t.index ["user_id"], name: "index_svgs_on_user_id"
  end

  create_table "todo_lists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_todo_lists_on_plan_id"
  end

  create_table "todos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "todo_list_id", null: false
    t.string "title", null: false
    t.text "body"
    t.time "begin_time"
    t.time "end_time"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todo_list_id"], name: "index_todos_on_todo_list_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "provider", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "maps", "plans"
  add_foreign_key "members", "plans"
  add_foreign_key "members", "roles"
  add_foreign_key "members", "users"
  add_foreign_key "plans", "users"
  add_foreign_key "roles", "plans"
  add_foreign_key "svgs", "maps"
  add_foreign_key "svgs", "todo_lists"
  add_foreign_key "svgs", "users"
  add_foreign_key "todo_lists", "plans"
  add_foreign_key "todos", "todo_lists"
end
