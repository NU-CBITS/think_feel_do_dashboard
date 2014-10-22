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

ActiveRecord::Schema.define(version: 20141020191836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "think_feel_do_dashboard_arms", force: true do |t|
    t.string   "name"
    t.integer  "project_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "think_feel_do_dashboard_coach_assignments", force: true do |t|
    t.integer  "coach_id",       null: false
    t.integer  "participant_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "think_feel_do_dashboard_groups", force: true do |t|
    t.integer  "arm_id",     null: false
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "think_feel_do_dashboard_memberships", force: true do |t|
    t.integer  "group_id",       null: false
    t.integer  "participant_id", null: false
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "think_feel_do_dashboard_participants", force: true do |t|
    t.string   "contact_preference", default: ""
    t.string   "display_name",       default: ""
    t.string   "email",                           null: false
    t.string   "phone_number"
    t.string   "study_id",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "think_feel_do_dashboard_projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "think_feel_do_dashboard_users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
