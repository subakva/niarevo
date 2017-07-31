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

ActiveRecord::Schema.define(version: 20170731052657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dreams", id: :serial, force: :cascade do |t|
    t.text "description", null: false
    t.integer "user_id"
    t.integer "dreamer_tag_count", default: 0, null: false
    t.integer "dream_tag_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "private", default: false, null: false
    t.string "dream_tags", default: [], null: false, array: true
    t.string "dreamer_tags", default: [], null: false, array: true
    t.index ["created_at"], name: "index_dreams_on_created_at"
    t.index ["dream_tag_count"], name: "index_dreams_on_dream_tag_count"
    t.index ["dream_tags"], name: "index_dreams_on_dream_tags", using: :gin
    t.index ["dreamer_tag_count"], name: "index_dreams_on_dreamer_tag_count"
    t.index ["dreamer_tags"], name: "index_dreams_on_dreamer_tags", using: :gin
    t.index ["updated_at"], name: "index_dreams_on_updated_at"
    t.index ["user_id", "private"], name: "index_dreams_on_user_id_and_private"
  end

  create_table "invites", id: :serial, force: :cascade do |t|
    t.string "message", limit: 255
    t.string "recipient_name", limit: 64, null: false
    t.string "email", limit: 255, null: false
    t.integer "user_id", null: false
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "user_id"], name: "index_invites_on_email_and_user_id", unique: true
    t.index ["email"], name: "index_invites_on_email"
    t.index ["sent_at"], name: "index_invites_on_sent_at"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "taggable_id", null: false
    t.string "taggable_type", limit: 32, null: false
    t.string "context", limit: 32
    t.integer "tagger_id"
    t.string "tagger_type", limit: 32
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "context"], name: "idx_taggings_by_tags"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "idx_taggings_by_taggable"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type", "context"], name: "idx_taggings_by_tagger"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 32, null: false
    t.string "email", limit: 255, null: false
    t.string "crypted_password", limit: 255, null: false
    t.string "password_salt", limit: 255, null: false
    t.string "persistence_token", limit: 255, null: false
    t.string "single_access_token", limit: 255, null: false
    t.string "perishable_token", limit: 255, null: false
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip", limit: 46
    t.string "last_login_ip", limit: 46
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["perishable_token"], name: "index_users_on_perishable_token", unique: true
    t.index ["persistence_token"], name: "index_users_on_persistence_token", unique: true
    t.index ["single_access_token"], name: "index_users_on_single_access_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "dreams", "users", name: "dreams_user_id_fk", on_delete: :cascade
  add_foreign_key "invites", "users", name: "invites_user_id_fk", on_delete: :cascade
  add_foreign_key "taggings", "tags", name: "taggings_tag_id_fk", on_delete: :cascade
end
