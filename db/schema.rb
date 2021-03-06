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

ActiveRecord::Schema.define(:version => 20120118200236) do

  create_table "am_configurations", :force => true do |t|
    t.boolean  "structural_markup_enabled"
    t.boolean  "structural_markup_extension_whole_document"
    t.boolean  "structural_markup_extension_first_level"
    t.boolean  "structural_markup_extension_second_level"
    t.boolean  "structural_markup_extension_third_level"
    t.boolean  "structural_markup_depth_all"
    t.string   "structural_markup_depth_mark"
    t.boolean  "semantic_markup_enabled"
    t.boolean  "semantic_markup_extension_whole_document"
    t.boolean  "semantic_markup_extension_persons"
    t.boolean  "semantic_markup_extension_organizations"
    t.boolean  "semantic_markup_extension_documents"
    t.boolean  "semantic_markup_extension_places"
    t.boolean  "semantic_markup_depth_all"
    t.string   "semantic_markup_depth_mark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "am_result_id"
  end

  create_table "am_module_configurations", :force => true do |t|
    t.string   "ws_endpoint"
    t.integer  "person_threshold"
    t.integer  "place_threshold"
    t.integer  "organization_threshold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "am_observations", :force => true do |t|
    t.integer  "am_run_observation_type_id"
    t.integer  "line"
    t.string   "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "am_result_id"
  end

  create_table "am_results", :force => true do |t|
    t.datetime "run_date"
    t.integer  "ot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "am_run_observation_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "task_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ot_id"
  end

  create_table "bitacoras", :force => true do |t|
    t.integer  "bulletin_id"
    t.integer  "frbr_manifestation_id"
    t.integer  "tramite_constitucional_id"
    t.integer  "tramite_normativo_id"
    t.text     "comments"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debate_types", :force => true do |t|
    t.integer  "ordinal"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_users_by_ot_types", :force => true do |t|
    t.integer  "ot_type_id"
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delivery_methods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_type_am_configurations", :force => true do |t|
    t.integer  "frbr_bcn_id"
    t.boolean  "structural_markup_enabled"
    t.boolean  "structural_markup_extension_whole_document"
    t.boolean  "structural_markup_extension_first_level"
    t.boolean  "structural_markup_extension_second_level"
    t.boolean  "structural_markup_extension_third_level"
    t.boolean  "structural_markup_depth_all"
    t.string   "structural_markup_depth_mark"
    t.boolean  "semantic_markup_enabled"
    t.boolean  "semantic_markup_extension_whole_document"
    t.boolean  "semantic_markup_extension_persons"
    t.boolean  "semantic_markup_extension_organizations"
    t.boolean  "semantic_markup_extension_documents"
    t.boolean  "semantic_markup_extension_places"
    t.boolean  "semantic_markup_depth_all"
    t.string   "semantic_markup_depth_mark"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "delivery_method_id"
    t.integer  "intermediary_id"
  end

  create_table "intermediaries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markup_tools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "observation_types", :force => true do |t|
    t.string   "name"
    t.integer  "ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "observations", :force => true do |t|
    t.integer  "ot_id"
    t.integer  "user_id"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "observation_type_id"
  end

  create_table "ot_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ordinal"
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
    t.string   "by_request_of"
    t.integer  "ot_state_id"
  end

  create_table "poblamiento_file_formats", :force => true do |t|
    t.string   "format_spec"
    t.integer  "ordinal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poblamiento_generated_params", :force => true do |t|
    t.integer  "ot_id"
    t.integer  "legislature"
    t.integer  "session"
    t.date     "session_date"
    t.string   "processing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poblamiento_import_locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poblamiento_params", :force => true do |t|
    t.integer  "ot_id"
    t.integer  "frbr_entity_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority_id"
    t.integer  "intermediary_id"
    t.integer  "file_format_id"
    t.integer  "location_id"
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

  create_table "target_document_versions", :force => true do |t|
    t.integer  "ot_id"
    t.integer  "user_id"
    t.integer  "markup_tool_id"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_transitions", :force => true do |t|
    t.string   "workflow"
    t.string   "from_state"
    t.string   "to_state"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "ordinal"
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
    t.string   "xpath_section"
    t.integer  "predecessor_id"
    t.integer  "successor_id"
  end

  create_table "taxonomy_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxonomy_terms", :force => true do |t|
    t.integer  "taxonomy_category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tp_generated_params", :force => true do |t|
    t.integer  "ot_id"
    t.integer  "legislature"
    t.integer  "session"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "session_date"
    t.string   "action"
  end

  create_table "tp_parameters", :force => true do |t|
    t.boolean  "restrict_chamber_enabled"
    t.integer  "organism_id"
    t.integer  "legislature_id"
    t.integer  "session_id"
    t.boolean  "restrict_date_enabled"
    t.date     "from_date"
    t.date     "to_date"
    t.boolean  "restrict_person_enabled"
    t.string   "party_id"
    t.string   "person_id"
    t.string   "participation_type_id"
    t.string   "quality_type_id"
    t.boolean  "free_search_enabled"
    t.string   "free_search_text"
    t.boolean  "taxonomy_search_enabled"
    t.string   "taxonomy_category_id"
    t.string   "taxonomy_term_id"
    t.boolean  "restrict_ds_enabled"
    t.string   "ds_part_id"
    t.integer  "ds_page"
    t.integer  "ds_tome"
    t.boolean  "restrict_law_enabled"
    t.string   "bill"
    t.string   "law"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ot_id"
    t.integer  "document_type_id"
    t.integer  "debate_type_id"
  end

  create_table "tramite_constitucionals", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tramite_normativos", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
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
