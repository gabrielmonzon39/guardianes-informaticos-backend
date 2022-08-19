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

ActiveRecord::Schema[7.0].define(version: 2022_08_12_020717) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_schedules", force: :cascade do |t|
    t.integer "day_of_week"
    t.integer "start"
    t.integer "end"
    t.bigint "client_clients_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_clients_id"], name: "index_client_schedules_on_client_clients_id"
  end

  create_table "worker_schedules", force: :cascade do |t|
    t.datetime "time", precision: nil
    t.boolean "confirmed", default: false
    t.bigint "worker_workers_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["worker_workers_id"], name: "index_worker_schedules_on_worker_workers_id"
  end

  create_table "worker_workers", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.bigint "client_clients_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_clients_id"], name: "index_worker_workers_on_client_clients_id"
  end

  add_foreign_key "client_schedules", "client_clients", column: "client_clients_id"
  add_foreign_key "worker_schedules", "worker_workers", column: "worker_workers_id"
  add_foreign_key "worker_workers", "client_clients", column: "client_clients_id"
end
