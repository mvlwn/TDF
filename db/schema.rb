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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120720072615) do

  create_table "player_riders", :force => true do |t|
    t.integer  "player_id"
    t.integer  "rider_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "player_riders", ["player_id"], :name => "index_player_riders_on_player_id"
  add_index "player_riders", ["rider_id"], :name => "index_player_riders_on_rider_id"

  create_table "players", :force => true do |t|
    t.string   "name",                   :default => "",    :null => false
    t.string   "team_name",              :default => "",    :null => false
    t.integer  "points",                 :default => 0,     :null => false
    t.boolean  "paid",                   :default => false, :null => false
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "disabled",               :default => false
  end

  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["points"], :name => "index_players_on_points"
  add_index "players", ["reset_password_token"], :name => "index_players_on_reset_password_token", :unique => true

  create_table "riders", :force => true do |t|
    t.integer  "team_id"
    t.string   "team_name"
    t.integer  "number"
    t.integer  "ad_code",                                :null => false
    t.string   "ad_role"
    t.string   "first_name",                             :null => false
    t.string   "last_name",                              :null => false
    t.integer  "price",                                  :null => false
    t.integer  "points",              :default => 0
    t.boolean  "confirmed",           :default => false
    t.boolean  "rejected",            :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "efficiency_in_cents"
    t.boolean  "withdrawn",           :default => false
  end

  add_index "riders", ["ad_code"], :name => "index_riders_on_ad_code"
  add_index "riders", ["number"], :name => "index_riders_on_number"
  add_index "riders", ["team_id"], :name => "index_riders_on_team_id"

  create_table "scores", :force => true do |t|
    t.integer  "number"
    t.integer  "rider_id"
    t.integer  "stage_id"
    t.integer  "category"
    t.integer  "ranking"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scores", ["category"], :name => "index_scores_on_category"
  add_index "scores", ["number"], :name => "index_scores_on_number"
  add_index "scores", ["rider_id"], :name => "index_scores_on_rider_id"
  add_index "scores", ["stage_id"], :name => "index_scores_on_stage_id"

  create_table "stages", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "description"
    t.float    "distance"
    t.date     "ridden_on"
    t.text     "yellow_results"
    t.text     "green_results"
    t.text     "dotted_results"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "stages", ["number"], :name => "index_stages_on_number"
  add_index "stages", ["ridden_on"], :name => "index_stages_on_ridden_on"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
