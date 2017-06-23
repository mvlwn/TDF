# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170623213735) do

  create_table "player_riders", force: :cascade do |t|
    t.integer  "player_id",           limit: 4
    t.integer  "rider_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "substitute_rider_id", limit: 4
    t.integer  "points",              limit: 4
  end

  add_index "player_riders", ["player_id"], name: "index_player_riders_on_player_id", using: :btree
  add_index "player_riders", ["rider_id"], name: "index_player_riders_on_rider_id", using: :btree
  add_index "player_riders", ["substitute_rider_id"], name: "index_player_riders_on_substitute_rider_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "",    null: false
    t.string   "team_name",              limit: 255, default: "",    null: false
    t.integer  "points",                 limit: 4,   default: 0,     null: false
    t.boolean  "paid",                               default: false, null: false
    t.boolean  "admin",                              default: false, null: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disabled",                           default: false
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["points"], name: "index_players_on_points", using: :btree
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree

  create_table "rider_stages", force: :cascade do |t|
    t.integer  "rider_id",   limit: 4
    t.integer  "stage_id",   limit: 4
    t.integer  "points",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rider_stages", ["rider_id"], name: "index_rider_stages_on_rider_id", using: :btree
  add_index "rider_stages", ["stage_id"], name: "index_rider_stages_on_stage_id", using: :btree

  create_table "riders", force: :cascade do |t|
    t.integer  "team_id",              limit: 4
    t.string   "team_name",            limit: 255
    t.integer  "number",               limit: 4
    t.string   "first_name",           limit: 255,                   null: false
    t.string   "last_name",            limit: 255,                   null: false
    t.integer  "price",                limit: 4,                     null: false
    t.integer  "points",               limit: 4,     default: 0
    t.boolean  "confirmed",                          default: false
    t.boolean  "rejected",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "efficiency_in_cents",  limit: 4
    t.boolean  "abandoned",                          default: false
    t.integer  "stage_id",             limit: 4
    t.integer  "scorito_id",           limit: 4
    t.integer  "scorito_team_id",      limit: 4
    t.string   "name",                 limit: 255
    t.string   "short_name",           limit: 255
    t.string   "last_name_prefix",     limit: 255
    t.integer  "age",                  limit: 4
    t.integer  "weight",               limit: 4
    t.integer  "height",               limit: 4
    t.string   "nationality",          limit: 255
    t.string   "nationality_flag_url", limit: 255
    t.string   "team_jersey_url",      limit: 255
    t.integer  "overall_skill",        limit: 4
    t.integer  "time_trial_skill",     limit: 4
    t.integer  "sprinting_skill",      limit: 4
    t.integer  "punching_skill",       limit: 4
    t.integer  "climbing_skill",       limit: 4
    t.integer  "hills_skill",          limit: 4
    t.integer  "cobblestones_skill",   limit: 4
    t.text     "description",          limit: 65535
  end

  add_index "riders", ["number"], name: "index_riders_on_number", using: :btree
  add_index "riders", ["scorito_id"], name: "index_riders_on_scorito_id", using: :btree
  add_index "riders", ["scorito_team_id"], name: "index_riders_on_scorito_team_id", using: :btree
  add_index "riders", ["stage_id"], name: "index_riders_on_stage_id", using: :btree
  add_index "riders", ["team_id"], name: "index_riders_on_team_id", using: :btree

  create_table "scores", force: :cascade do |t|
    t.integer  "number",     limit: 4
    t.integer  "rider_id",   limit: 4
    t.integer  "stage_id",   limit: 4
    t.integer  "category",   limit: 4
    t.integer  "ranking",    limit: 4
    t.integer  "points",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["category"], name: "index_scores_on_category", using: :btree
  add_index "scores", ["number"], name: "index_scores_on_number", using: :btree
  add_index "scores", ["rider_id"], name: "index_scores_on_rider_id", using: :btree
  add_index "scores", ["stage_id"], name: "index_scores_on_stage_id", using: :btree

  create_table "stages", force: :cascade do |t|
    t.integer  "number",         limit: 4
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.float    "distance",       limit: 24
    t.date     "ridden_on"
    t.text     "yellow_results", limit: 65535
    t.text     "green_results",  limit: 65535
    t.text     "dotted_results", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email_text",     limit: 65535
  end

  add_index "stages", ["number"], name: "index_stages_on_number", using: :btree
  add_index "stages", ["ridden_on"], name: "index_stages_on_ridden_on", using: :btree

  create_table "subpool_players", force: :cascade do |t|
    t.integer  "subpool_id", limit: 4
    t.integer  "player_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subpool_players", ["player_id"], name: "index_subpool_players_on_player_id", using: :btree
  add_index "subpool_players", ["subpool_id"], name: "index_subpool_players_on_subpool_id", using: :btree

  create_table "subpools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "creator_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subpools", ["creator_id"], name: "index_subpools_on_creator_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scorito_id", limit: 4
  end

  add_index "teams", ["scorito_id"], name: "index_teams_on_scorito_id", using: :btree

end
