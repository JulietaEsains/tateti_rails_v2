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

ActiveRecord::Schema[7.0].define(version: 2022_06_08_124028) do
  create_table "games", force: :cascade do |t|
    t.integer "player_x_id", null: false
    t.integer "player_o_id"
    t.boolean "over", default: false, null: false
    t.string "cells"
    t.string "turn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_o_id"], name: "index_games_on_player_o_id"
    t.index ["player_x_id"], name: "index_games_on_player_x_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
