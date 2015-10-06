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

ActiveRecord::Schema.define(version: 20150930201712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "applications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "version"
    t.string   "redirect_uri"
    t.string   "description"
    t.string   "secret"
    t.string   "scopes",       default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "authorizations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "application_id"
    t.uuid     "membership_id"
    t.string   "scopes",         default: [],              array: true
    t.datetime "revoked_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "authorizations", ["application_id", "membership_id"], name: "index_authorizations_on_application_and_membership", unique: true, using: :btree

  create_table "memberships", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "organization_id"
    t.uuid     "user_id"
    t.boolean  "authorized",          default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.hstore   "legacy_integrations"
  end

  add_index "memberships", ["legacy_integrations"], name: "index_memberships_on_legacy_integrations", using: :gin
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
    t.uuid     "profileable_id"
    t.string   "profileable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "profiles", ["profileable_id", "profileable_type"], name: "index_profiles_on_profileable_id_and_profileable_type", unique: true, using: :btree

  create_table "service_instances", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "uri"
    t.uuid     "service_id"
    t.uuid     "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "service_instances", ["service_id", "organization_id"], name: "index_service_instances_on_service_id_and_organization_id", unique: true, using: :btree

  create_table "service_types", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "services", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "type_id"
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "services", ["type_id"], name: "index_services_on_type_id", using: :btree

  create_table "subscriptions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "application_id"
    t.uuid     "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "subscriptions", ["application_id", "organization_id"], name: "index_subscriptions_on_application_and_organization", unique: true, using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "token"
    t.string   "activation_token"
    t.boolean  "activated",                  default: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "last_password_retrieval_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
