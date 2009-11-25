# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091125005208) do

  create_table "dreams", :force => true do |t|
    t.text     "description", :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dreams", ["created_at"], :name => "index_dreams_on_created_at"
  add_index "dreams", ["updated_at"], :name => "index_dreams_on_updated_at"
  add_index "dreams", ["user_id"], :name => "index_dreams_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :null => false
    t.string   "taggable_type", :null => false
    t.integer  "taggable_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["created_at"], :name => "index_taggings_on_created_at"
  add_index "taggings", ["tag_id", "taggable_type", "taggable_id"], :name => "index_taggings_on_tag_id_and_taggable_type_and_taggable_id", :unique => true
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "kind",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["created_at"], :name => "index_tags_on_created_at"
  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind"

  create_table "users", :force => true do |t|
    t.string   "username",                               :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",              :default => false, :null => false
  end

  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  add_foreign_key "dreams", "users", :name => "dreams_user_id_fk", :dependent => :delete

  add_foreign_key "taggings", "tags", :name => "taggings_tag_id_fk", :dependent => :delete

end
