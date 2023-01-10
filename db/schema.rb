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

ActiveRecord::Schema[7.0].define(version: 2023_01_10_134624) do
  create_table "field_associations", force: :cascade do |t|
    t.integer "field_id", null: false
    t.string "target_type", null: false
    t.integer "target_id", null: false
    t.string "value"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_field_associations_on_field_id"
    t.index ["target_type", "target_id"], name: "index_field_associations_on_target"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.json "metadata", default: {}
    t.json "policy", default: {}
    t.integer "position", default: 0
    t.string "source_type"
    t.integer "source_id"
    t.string "field_type", default: "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_type", "source_id"], name: "index_fields_on_source"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "todo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_id"], name: "index_items_on_todo_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "field_associations", "fields"
  add_foreign_key "items", "todos"
end
