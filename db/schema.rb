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

ActiveRecord::Schema.define(:version => 20111116014455) do

  create_table "audits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "task_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ot_id"
  end

  create_table "frbr_bcn_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frbr_document_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frbr_entities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frbr_expressions", :force => true do |t|
    t.integer  "frbr_work_id"
    t.integer  "frbr_document_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
    t.string   "language"
  end

  create_table "frbr_manifestations", :force => true do |t|
    t.integer  "frbr_expression_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frbr_works", :force => true do |t|
    t.integer  "frbr_bcn_type_id"
    t.integer  "frbr_entity_id"
    t.integer  "session"
    t.date     "publication_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "event_date"
    t.integer  "legislature"
  end

  create_table "observations", :force => true do |t|
    t.integer  "ot_id"
    t.integer  "user_id"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ot_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ot_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ots", :force => true do |t|
    t.integer  "created_by"
    t.datetime "created_on"
    t.datetime "completed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ot_type_id"
    t.integer  "priority_id"
    t.string   "source_frbr_manifestation_id"
    t.string   "target_frbr_manifestation_id"
    t.datetime "target_date"
    t.string   "current_step"
    t.integer  "current_task_id"
    t.integer  "parent_ot_id"
    t.boolean  "read",                         :default => false
  end

  create_table "priorities", :force => true do |t|
    t.string   "name"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "created_by"
    t.datetime "created_on"
    t.datetime "completed_on"
    t.integer  "current_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ot_id"
    t.integer  "task_type_id"
    t.string   "workflow_state"
    t.string   "type"
    t.integer  "priority_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "user_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
