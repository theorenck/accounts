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

ActiveRecord::Schema.define(version: 20150904180102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "memberships", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "organization_id"
    t.uuid     "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "memberships", ["organization_id", "user_id"], name: "index_memberships_on_organization_id_and_user_id", unique: true, using: :btree

  create_table "organizations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.uuid     "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "organizations", ["owner_id"], name: "index_organizations_on_owner_id", using: :btree

  create_table "profiles", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "description"
    t.integer  "profileable_id"
    t.string   "profileable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "profiles", ["profileable_type", "profileable_id"], name: "index_profiles_on_profileable_type_and_profileable_id", using: :btree

  create_table "service_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "services", force: :cascade do |t|
    t.integer  "service_type_id"
    t.integer  "organization_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "services", ["organization_id"], name: "index_services_on_organization_id", using: :btree
  add_index "services", ["service_type_id"], name: "index_services_on_service_type_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
