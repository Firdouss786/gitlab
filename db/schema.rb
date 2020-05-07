# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_18_175308) do

  create_table "accesses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status", default: "enabled"
    t.string "accessible_type", null: false
    t.bigint "accessible_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accessible_type", "accessible_id"], name: "index_accesses_on_accessible_type_and_accessible_id"
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "closed_at"
    t.datetime "boarded_at"
    t.datetime "unboarded_at"
    t.bigint "created_by_id"
    t.bigint "station_id"
    t.boolean "is_open", default: false
    t.string "inbound_flight_number"
    t.bigint "inbound_airport_id"
    t.bigint "outbound_airport_id"
    t.string "outbound_flight_number"
    t.bigint "aircraft_id"
    t.bigint "closed_by_id"
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", default: "CREATED"
    t.bigint "flight_id"
    t.index ["aircraft_id"], name: "ix_activity_activity_aircraft_5"
    t.index ["closed_by_id"], name: "ix_activity_activity_closer_99"
    t.index ["created_by_id"], name: "ix_activity_activity_creator_1"
    t.index ["flight_id"], name: "index_activities_on_flight_id"
    t.index ["inbound_airport_id"], name: "ix_activity_activity_inboundairport_3"
    t.index ["outbound_airport_id"], name: "ix_activity_activity_outboundairport_4"
    t.index ["station_id"], name: "ix_activity_activity_location_2"
    t.index ["user_id"], name: "ix_activity_user"
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "zip"
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.string "country"
    t.string "state"
    t.string "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjustments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "adjustable_type"
    t.bigint "adjustable_id"
    t.integer "quantity"
    t.string "state", default: "created"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["adjustable_type", "adjustable_id"], name: "index_adjustments_on_adjustable_type_and_adjustable_id"
    t.index ["state"], name: "index_adjustments_on_state"
  end

  create_table "aircraft_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "state"
    t.bigint "aircraft_id"
    t.integer "current_flight_id"
    t.integer "current_activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id"], name: "index_aircraft_statuses_on_aircraft_id"
    t.index ["current_activity_id"], name: "index_aircraft_statuses_on_current_activity_id"
    t.index ["current_flight_id"], name: "index_aircraft_statuses_on_current_flight_id"
  end

  create_table "aircraft_types", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.bigint "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["manufacturer_id"], name: "ix_aircrafttype_aircrafttype_oem_20"
  end

  create_table "aircrafts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "tail"
    t.string "msn"
    t.string "fin"
    t.string "registration"
    t.datetime "eis"
    t.datetime "tot"
    t.text "description", size: :long
    t.bigint "fleet_id"
    t.bigint "airline_id"
    t.boolean "locked", default: false
    t.boolean "active", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", default: "active"
    t.index ["airline_id"], name: "ix_aircraft_aircraft_airline_11"
    t.index ["fleet_id"], name: "ix_aircraft_aircraft_configuration_10"
  end

  create_table "airlines", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "iata_code"
    t.string "icao_code"
    t.string "name"
    t.string "alias"
    t.string "callsign"
    t.string "country"
    t.boolean "customer", default: false
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", default: "active"
  end

  create_table "airports", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "iata_code"
    t.string "icao_code"
    t.string "name"
    t.string "country"
    t.string "city"
    t.string "latitude"
    t.string "longitude"
    t.string "dst"
    t.float "timezone", limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["icao_code"], name: "index_airports_on_icao_code"
  end

  create_table "approvals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "approval_via_email", default: false
    t.boolean "acknowledge_after_update", default: false
    t.integer "approvable_id"
    t.string "approvable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "requestee_id"
    t.string "status", default: "pending"
    t.index ["approvable_type", "approvable_id"], name: "index_approvals_on_approvable_type_and_approvable_id", unique: true
    t.index ["requestee_id"], name: "index_approvals_on_requestee_id"
    t.index ["status"], name: "index_approvals_on_status"
  end

  create_table "approvals_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "approval_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "archivals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason"
    t.index ["user_id"], name: "index_archivals_on_user_id"
  end

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "fault_id"
    t.boolean "cid"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fault_id"], name: "index_attachments_on_fault_id"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "campaigns", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "task_template_id"
    t.string "state"
    t.datetime "scheduled_start"
    t.datetime "scheduled_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_template_id"], name: "index_campaigns_on_task_template_id"
  end

  create_table "certificates", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.boolean "expired", default: false
    t.string "filename"
    t.string "reference"
    t.string "governance", limit: 10
    t.bigint "stock_item_id"
    t.string "hdfs_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expired_at"
    t.index ["stock_item_id"], name: "ix_certificate_data_certificatedata_stockItem_31"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "description"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "completions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "completable_id"
    t.string "completable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completable_type", "completable_id"], name: "index_completions_on_completable_type_and_completable_id"
    t.index ["user_id"], name: "index_completions_on_user_id"
  end

  create_table "config_applicabilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "applicable_content"
    t.string "applicable_software"
    t.bigint "fleet_id"
    t.bigint "task_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fleet_id"], name: "index_config_applicabilities_on_fleet_id"
    t.index ["task_template_id"], name: "index_config_applicabilities_on_task_template_id"
  end

  create_table "config_files", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "fleet_id"
    t.string "file_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fleet_id"], name: "index_config_files_on_fleet_id"
    t.index ["user_id"], name: "index_config_files_on_user_id"
  end

  create_table "corrective_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "job_started_at"
    t.bigint "performed_by_id"
    t.bigint "user_id"
    t.bigint "defer_reason_id"
    t.bigint "maintenance_action_id"
    t.text "logbook_text", size: :long
    t.string "document_reference"
    t.bigint "replacement_id"
    t.boolean "opdef", default: false
    t.bigint "removal_reason_id"
    t.bigint "batch_quantity"
    t.bigint "activity_id"
    t.bigint "fault_id"
    t.bigint "product_id"
    t.string "batch_number"
    t.string "logbook_reference", limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["activity_id"], name: "ix_correctiveaction_correctiveaction_activity_42"
    t.index ["defer_reason_id"], name: "ix_correctiveaction_correctiveaction_deferreason_38"
    t.index ["fault_id"], name: "ix_correctiveaction_correctiveaction_fault_43"
    t.index ["maintenance_action_id"], name: "ix_correctiveaction_correctiveaction_maintenanceaction_39"
    t.index ["performed_by_id"], name: "ix_correctiveaction_correctiveaction_user_36"
    t.index ["product_id"], name: "ix_correctiveaction_correctiveaction_product_100"
    t.index ["removal_reason_id"], name: "ix_correctiveaction_correctiveaction_removalreason_41"
    t.index ["replacement_id"], name: "ix_correctiveaction_correctiveaction_removal_40"
    t.index ["user_id"], name: "ix_correctiveaction_correctiveaction_creator_37"
  end

  create_table "defer_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discrepancies", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "category"
    t.text "description", size: :long
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "discrepancy_category_id"
    t.bigint "archival_id"
    t.index ["archival_id"], name: "index_discrepancies_on_archival_id"
    t.index ["discrepancy_category_id"], name: "index_discrepancies_on_discrepancy_category_id"
    t.index ["name", "discrepancy_category_id"], name: "index_discrepancies_on_name_and_discrepancy_category_id", unique: true
  end

  create_table "discrepancy_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_discrepancy_categories_on_category", unique: true
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.bigint "stock_item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["eventable_type", "eventable_id"], name: "index_events_on_eventable_type_and_eventable_id"
    t.index ["stock_item_id"], name: "index_events_on_stock_item_id"
  end

  create_table "faults", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "logbook_reference"
    t.string "discovered"
    t.bigint "discrepancy_id"
    t.bigint "recorded_by_id"
    t.bigint "user_id"
    t.bigint "resolving_corrective_action_id"
    t.text "technician_comment", size: :long
    t.string "action_carried"
    t.string "logbook_text"
    t.string "raised_on_flight"
    t.boolean "confirmed", default: false
    t.boolean "inbound_deferred", default: false
    t.boolean "cid", default: false
    t.string "attachment_filename"
    t.string "attachment"
    t.string "state", default: "ACTIVE"
    t.bigint "impacted_seat_count"
    t.text "seats_impacted", size: :long
    t.datetime "raised_at"
    t.string "deferral_reference"
    t.text "controller_comment", size: :long
    t.bigint "aircraft_id"
    t.bigint "activity_id"
    t.string "mel_cetegory", limit: 1
    t.boolean "alert_raised", default: false
    t.string "fmr"
    t.string "pirep"
    t.string "mcc_status", limit: 12
    t.datetime "resolved_at"
    t.bigint "defer_quantity"
    t.text "mcc_description", size: :long
    t.bigint "defer_reason_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "approval_state"
    t.boolean "deferral", default: false
    t.index ["activity_id"], name: "ix_fault_fault_log_49"
    t.index ["aircraft_id"], name: "ix_fault_fault_aircraft_48"
    t.index ["defer_reason_id"], name: "ix_fault_fault_deferreason_121"
    t.index ["discrepancy_id"], name: "ix_fault_fault_discrepancy_44"
    t.index ["recorded_by_id"], name: "ix_fault_fault_user_45"
    t.index ["resolving_corrective_action_id"], name: "ix_fault_fault_resolution_47"
    t.index ["user_id"], name: "ix_fault_fault_creator_46"
  end

  create_table "feature_flags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fleets", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.string "install_type"
    t.string "lopa_path"
    t.bigint "first_class_seat_count"
    t.bigint "business_class_seat_count"
    t.bigint "premium_class_seat_count"
    t.bigint "economy_class_seat_count"
    t.bigint "aircraft_type_id"
    t.bigint "software_platform_id"
    t.bigint "airline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", default: "active"
    t.index ["aircraft_type_id"], name: "ix_configuration_configuration_actype_32"
    t.index ["airline_id"], name: "ix_configuration_configuration_airline_34"
    t.index ["software_platform_id"], name: "ix_configuration_configuration_ife_33"
  end

  create_table "flight_subscriptions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vendor_subscription_id"
    t.bigint "aircraft_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["aircraft_id"], name: "index_flight_subscriptions_on_aircraft_id"
    t.index ["vendor_subscription_id"], name: "index_flight_subscriptions_on_vendor_subscription_id"
  end

  create_table "flights", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "vendor_id"
    t.string "flight_number"
    t.string "origin_airport_code"
    t.string "destination_airport_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "aircraft_id"
    t.bigint "airline_id"
    t.integer "origin_airport_id"
    t.integer "destination_airport_id"
    t.bigint "aircraft_status_id"
    t.datetime "filed_departure_time"
    t.datetime "actual_departure_time"
    t.datetime "estimated_arrival_time"
    t.datetime "actual_arrival_time"
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
    t.index ["aircraft_status_id"], name: "index_flights_on_aircraft_status_id"
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["destination_airport_id"], name: "index_flights_on_destination_airport_id"
    t.index ["origin_airport_id"], name: "index_flights_on_origin_airport_id"
    t.index ["vendor_id"], name: "index_flights_on_vendor_id"
  end

  create_table "level_recommendations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "recommended_quantity"
    t.bigint "stock_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "ix_stock_recommendation_stock_recommendation_productsubtype_78"
    t.index ["stock_location_id"], name: "ix_stock_recommendation_stock_recommendation_stock_79"
  end

  create_table "maintenance_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "subject_class"
    t.string "action"
    t.integer "subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "permission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permission_id"], name: "index_permissions_profiles_on_permission_id"
    t.index ["profile_id"], name: "index_permissions_profiles_on_profile_id"
  end

  create_table "product_allotments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "quantity"
    t.bigint "fleet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["fleet_id"], name: "ix_bomitem_bomitem_bom_28"
    t.index ["product_id"], name: "ix_bomitem_bomitem_productsubtype_27"
  end

  create_table "product_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "product_type", limit: 11
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "part_number"
    t.string "name"
    t.float "price", limit: 53
    t.bigint "shelf_life"
    t.text "description", size: :long
    t.bigint "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_category_id"], name: "ix_productsubtype_productsubtype_product_54"
  end

  create_table "profiles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "airline_id"
    t.string "mcc_email"
    t.text "repair_order_note", size: :long
    t.bigint "airport_id"
    t.string "mailing_group_1", limit: 3000
    t.string "mailing_group_2", limit: 3000
    t.string "mailing_group_3", limit: 3000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", default: "active"
    t.index ["airline_id"], name: "ix_airlineprogram_airlineprogram_airline_22"
    t.index ["airport_id"], name: "ix_airlineprogram_airlineprogram_mainbase_120"
  end

  create_table "programs_stations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "program_id"
    t.bigint "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_programs_stations_on_program_id"
    t.index ["station_id"], name: "index_programs_stations_on_station_id"
  end

  create_table "removal_reasons", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.bigint "product_category_id"
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_category_id"], name: "ix_removalreason_removalreason_product_59"
  end

  create_table "repair_orders", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "user_name"
    t.string "ro_number"
    t.string "price"
    t.string "vendor"
    t.text "shipping_address"
    t.text "return_address"
    t.text "repair_comment", size: :long
    t.string "carrier_name"
    t.string "aircraft"
    t.string "removal_reason", limit: 3000
    t.string "part_number"
    t.string "part_description"
    t.string "serial_number"
    t.string "task_description"
    t.string "airway_bill_comment"
    t.datetime "removal_date"
    t.datetime "promised_at"
    t.boolean "expired", default: false
    t.string "ro_product_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "user_id"
    t.bigint "origin_stock_location_id"
    t.bigint "destination_stock_location_id"
    t.bigint "part_transaction_id"
    t.index ["destination_stock_location_id"], name: "index_repair_orders_on_destination_stock_location_id"
    t.index ["origin_stock_location_id"], name: "index_repair_orders_on_origin_stock_location_id"
    t.index ["part_transaction_id"], name: "index_repair_orders_on_part_transaction_id"
    t.index ["user_id"], name: "index_repair_orders_on_user_id"
  end

  create_table "replacements", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "on_wing_position"
    t.bigint "installed_stock_item_id"
    t.bigint "removed_stock_item_id"
    t.bigint "removal_reason_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "install_quantity"
    t.string "category"
    t.bigint "installed_product_id"
    t.bigint "removed_product_id"
    t.string "removed_model_numbers"
    t.string "removed_revision"
    t.index ["installed_product_id"], name: "index_replacements_on_installed_product_id"
    t.index ["installed_stock_item_id"], name: "ix_removal_removal_on_56"
    t.index ["removal_reason_id"], name: "ix_removal_removal_removalreason_58"
    t.index ["removed_product_id"], name: "index_replacements_on_removed_product_id"
    t.index ["removed_stock_item_id"], name: "ix_removal_removal_off_57"
  end

  create_table "seats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "col"
    t.integer "row"
    t.string "travel_class"
    t.integer "deck"
    t.integer "dsu_primary"
    t.integer "dsu_secondary"
    t.bigint "fleet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fleet_id"], name: "index_seats_on_fleet_id"
  end

  create_table "serviceable_part_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "manufacturer_part_number"
    t.string "manufacturer_part_number_barcode"
    t.string "serial_number"
    t.string "serial_number_barcode"
    t.string "part_name"
    t.string "manufacturer"
    t.string "modification_status"
    t.string "revision_status"
    t.string "batch_number"
    t.datetime "shelf_life_expiry"
    t.string "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "software_platforms", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "airport_id"
    t.bigint "user_id"
    t.bigint "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.index ["address_id"], name: "ix_station_station_address_73"
    t.index ["airport_id"], name: "ix_station_station_airport_71"
    t.index ["user_id"], name: "ix_station_station_owner_72"
  end

  create_table "stock_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "product_id"
    t.string "serial_number"
    t.string "model_numbers"
    t.string "revision"
    t.string "batch_number"
    t.string "category", limit: 11
    t.integer "quantity"
    t.bigint "lastest_transfer_id"
    t.bigint "stock_location_id"
    t.datetime "shelf_life_expiration"
    t.datetime "shelved_at"
    t.bigint "user_id"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["batch_number"], name: "index_stock_items_on_batch_number"
    t.index ["lastest_transfer_id"], name: "ix_stock_item_stockitem_lasttransaction_76"
    t.index ["product_id"], name: "ix_stock_item_stockitem_productSubType_75"
    t.index ["stock_location_id"], name: "ix_stock_item_stock_item_stock_77"
    t.index ["user_id"], name: "ix_stockitem_user"
  end

  create_table "stock_locations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "category", limit: 13
    t.bigint "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "parent_type"
    t.boolean "may_supply_to_aircraft"
    t.boolean "may_retrieve_from_aircraft"
    t.boolean "may_repair_on_site"
    t.boolean "may_exclude_from_global_pool"
    t.boolean "may_scrap"
    t.index ["parent_type"], name: "index_stock_locations_on_parent_type"
  end

  create_table "task_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "created_by_id"
    t.datetime "completed_at"
    t.integer "completion_percentage"
    t.text "logbook_text", size: :long
    t.bigint "activity_id"
    t.bigint "task_id"
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["activity_id"], name: "ix_taskexecutionitem_taskexecutionitem_log_86"
    t.index ["created_by_id"], name: "ix_taskexecutionitem_taskexecutionitem_creator_85"
    t.index ["task_id"], name: "ix_taskexecutionitem_taskexecutionitem_taskexecution_87"
    t.index ["user_id"], name: "ix_taskexecutionitem_user"
  end

  create_table "task_actions_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "task_action_id"
    t.bigint "user_id"
    t.index ["task_action_id"], name: "index_task_actions_users_on_task_action_id"
    t.index ["user_id"], name: "index_task_actions_users_on_user_id"
  end

  create_table "task_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.text "description", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "repeat_interval"
    t.string "state"
    t.integer "airline_id"
    t.integer "user"
    t.bigint "user_id"
    t.bigint "archival_id"
    t.string "mode"
    t.index ["airline_id"], name: "index_task_templates_on_airline_id"
    t.index ["archival_id"], name: "index_task_templates_on_archival_id"
    t.index ["user_id"], name: "index_task_templates_on_user_id"
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "created_by_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.text "logbook_text", size: :long
    t.integer "completion_percentage", default: 0
    t.bigint "started_in_activity_id"
    t.bigint "completed_in_activity_id"
    t.bigint "task_template_id"
    t.string "state", default: "created"
    t.bigint "aircraft_id"
    t.string "logbook_reference"
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "due_at"
    t.index ["aircraft_id"], name: "ix_taskexecution_taskexecution_aircraft_84"
    t.index ["completed_in_activity_id"], name: "ix_taskexecution_taskexecution_activitystop_82"
    t.index ["created_by_id"], name: "ix_taskexecution_taskexecution_creator_80"
    t.index ["started_in_activity_id"], name: "ix_taskexecution_taskexecution_activitystart_81"
    t.index ["task_template_id"], name: "ix_taskexecution_taskexecution_taskcard_83"
    t.index ["user_id"], name: "ix_taskexecution_user"
  end

  create_table "transfers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "state", limit: 6
    t.string "category", limit: 14
    t.string "comment"
    t.string "airway_bill"
    t.bigint "sent_by_id"
    t.bigint "received_by_id"
    t.bigint "stock_item_id"
    t.bigint "source_stock_location_id"
    t.bigint "destination_stock_location_id"
    t.string "filename"
    t.datetime "sent_at"
    t.datetime "received_at"
    t.bigint "created_by_id"
    t.bigint "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "from_state"
    t.string "to_state"
    t.index ["activity_id"], name: "ix_transaction_activity"
    t.index ["created_by_id"], name: "ix_transaction_user"
    t.index ["destination_stock_location_id"], name: "ix_transaction_transaction_destination_95"
    t.index ["received_by_id"], name: "ix_transaction_transaction_receiver_92"
    t.index ["sent_by_id"], name: "ix_transaction_transaction_shipper_91"
    t.index ["source_stock_location_id"], name: "ix_transaction_transaction_source_94"
    t.index ["stock_item_id"], name: "ix_transaction_transaction_stockitem_93"
  end

  create_table "unserviceable_part_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "reason_for_removal", limit: 3000
    t.datetime "removed_date"
    t.string "removed_during_task"
    t.string "work_order_number"
    t.string "aircraft"
    t.string "unserviceable_modification_status"
    t.string "unserviceable_revisionstatus"
    t.string "repair_order_number"
    t.string "unserviceable_part_name"
    t.string "removed_from_position"
    t.string "unserviceable_manufacturer_part_number"
    t.string "unserviceable_manufacturer"
    t.string "unserviceable_serial_number"
    t.string "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "job_title"
    t.bigint "default_airline_id"
    t.bigint "manager_id"
    t.boolean "locked", default: false
    t.boolean "active", default: true
    t.string "user_src_number", limit: 250
    t.string "email"
    t.string "secondary_email"
    t.integer "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "password_digest"
    t.datetime "password_expires_at"
    t.boolean "requires_verification", default: true
    t.bigint "home_station_id"
    t.string "phone_number"
    t.string "country_code"
    t.string "token"
    t.bigint "archival_id"
    t.index ["archival_id"], name: "index_users_on_archival_id"
    t.index ["default_airline_id"], name: "ix_user_user_airline_98"
    t.index ["home_station_id"], name: "index_users_on_home_station_id"
    t.index ["manager_id"], name: "ix_user_manager_user_id_106"
    t.index ["profile_id"], name: "fk_rails_a8794354f0"
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "version", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accesses", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "aircrafts", name: "fk_activity_activity_aircraft_5"
  add_foreign_key "activities", "airports", column: "inbound_airport_id", name: "fk_activity_activity_inboundairport_3"
  add_foreign_key "activities", "airports", column: "outbound_airport_id", name: "fk_activity_activity_outboundairport_4"
  add_foreign_key "activities", "users", column: "closed_by_id", name: "fk_activity_activity_closer_99"
  add_foreign_key "activities", "users", column: "created_by_id", name: "fk_activity_activity_creator_1"
  add_foreign_key "activities", "users", name: "fk_activity_user"
  add_foreign_key "aircraft_statuses", "aircrafts"
  add_foreign_key "aircraft_types", "manufacturers", name: "fk_aircrafttype_aircrafttype_oem_20"
  add_foreign_key "aircrafts", "airlines", name: "fk_aircraft_aircraft_airline_11"
  add_foreign_key "aircrafts", "fleets", name: "fk_aircraft_aircraft_configuration_10"
  add_foreign_key "approvals", "users", column: "requestee_id"
  add_foreign_key "archivals", "users"
  add_foreign_key "attachments", "faults"
  add_foreign_key "attachments", "users"
  add_foreign_key "campaigns", "task_templates"
  add_foreign_key "certificates", "stock_items", name: "fk_certificate_data_certificatedata_stockItem_31"
  add_foreign_key "comments", "users"
  add_foreign_key "completions", "users"
  add_foreign_key "config_applicabilities", "fleets"
  add_foreign_key "config_applicabilities", "task_templates"
  add_foreign_key "config_files", "fleets"
  add_foreign_key "config_files", "users"
  add_foreign_key "corrective_actions", "activities", name: "fk_correctiveaction_correctiveaction_activity_42"
  add_foreign_key "corrective_actions", "defer_reasons", name: "fk_correctiveaction_correctiveaction_deferreason_38"
  add_foreign_key "corrective_actions", "faults", name: "fk_correctiveaction_correctiveaction_fault_43"
  add_foreign_key "corrective_actions", "maintenance_actions", name: "fk_correctiveaction_correctiveaction_maintenanceaction_39"
  add_foreign_key "corrective_actions", "products", name: "fk_correctiveaction_correctiveaction_product_100"
  add_foreign_key "corrective_actions", "removal_reasons", name: "fk_correctiveaction_correctiveaction_removalreason_41"
  add_foreign_key "corrective_actions", "replacements", name: "fk_correctiveaction_correctiveaction_removal_40"
  add_foreign_key "corrective_actions", "users", column: "performed_by_id", name: "fk_correctiveaction_correctiveaction_user_36"
  add_foreign_key "corrective_actions", "users", name: "fk_correctiveaction_correctiveaction_creator_37"
  add_foreign_key "events", "stock_items"
  add_foreign_key "faults", "activities", name: "fk_fault_fault_log_49"
  add_foreign_key "faults", "aircrafts", name: "fk_fault_fault_aircraft_48"
  add_foreign_key "faults", "corrective_actions", column: "resolving_corrective_action_id", name: "fk_fault_fault_resolution_47"
  add_foreign_key "faults", "defer_reasons", name: "fk_fault_fault_deferreason_121"
  add_foreign_key "faults", "discrepancies", name: "fk_fault_fault_discrepancy_44"
  add_foreign_key "faults", "users", column: "recorded_by_id", name: "fk_fault_fault_user_45"
  add_foreign_key "faults", "users", name: "fk_fault_fault_creator_46"
  add_foreign_key "fleets", "aircraft_types", name: "fk_configuration_configuration_actype_32"
  add_foreign_key "fleets", "airlines", name: "fk_configuration_configuration_airline_34"
  add_foreign_key "fleets", "software_platforms", name: "fk_configuration_configuration_ife_33"
  add_foreign_key "flight_subscriptions", "aircrafts"
  add_foreign_key "flights", "aircraft_statuses"
  add_foreign_key "flights", "aircrafts"
  add_foreign_key "flights", "airlines"
  add_foreign_key "level_recommendations", "products", name: "fk_stock_recommendation_stock_recommendation_productsubtype_78"
  add_foreign_key "level_recommendations", "stock_locations", name: "fk_stock_recommendation_stock_recommendation_stock_79"
  add_foreign_key "product_allotments", "fleets"
  add_foreign_key "product_allotments", "products"
  add_foreign_key "product_allotments", "products", name: "fk_bomitem_bomitem_productsubtype_27"
  add_foreign_key "products", "product_categories", name: "fk_productsubtype_productsubtype_product_54"
  add_foreign_key "programs", "airlines", name: "fk_airlineprogram_airlineprogram_airline_22"
  add_foreign_key "programs", "airports", name: "fk_airlineprogram_airlineprogram_mainbase_120"
  add_foreign_key "programs_stations", "programs"
  add_foreign_key "programs_stations", "stations"
  add_foreign_key "removal_reasons", "product_categories", name: "fk_removalreason_removalreason_product_59"
  add_foreign_key "repair_orders", "replacements", column: "part_transaction_id"
  add_foreign_key "repair_orders", "stock_locations", column: "destination_stock_location_id"
  add_foreign_key "repair_orders", "stock_locations", column: "origin_stock_location_id"
  add_foreign_key "repair_orders", "users"
  add_foreign_key "replacements", "products", column: "installed_product_id"
  add_foreign_key "replacements", "products", column: "removed_product_id"
  add_foreign_key "replacements", "removal_reasons", name: "fk_removal_removal_removalreason_58"
  add_foreign_key "replacements", "stock_items", column: "installed_stock_item_id", name: "fk_removal_removal_on_56"
  add_foreign_key "replacements", "stock_items", column: "removed_stock_item_id", name: "fk_removal_removal_off_57"
  add_foreign_key "seats", "fleets"
  add_foreign_key "stations", "addresses", name: "fk_station_station_address_73"
  add_foreign_key "stations", "airports", name: "fk_station_station_airport_71"
  add_foreign_key "stations", "users", name: "fk_station_station_owner_72"
  add_foreign_key "stock_items", "products", name: "fk_stock_item_stockitem_productSubType_75"
  add_foreign_key "stock_items", "stock_locations", name: "fk_stock_item_stock_item_stock_77"
  add_foreign_key "stock_items", "transfers", column: "lastest_transfer_id", name: "fk_stock_item_stockitem_lasttransaction_76"
  add_foreign_key "stock_items", "users", name: "fk_stockitem_user"
  add_foreign_key "task_actions", "activities", name: "fk_taskexecutionitem_taskexecutionitem_log_86"
  add_foreign_key "task_actions", "tasks", name: "fk_taskexecutionitem_taskexecutionitem_taskexecution_87"
  add_foreign_key "task_actions", "users", column: "created_by_id", name: "fk_taskexecutionitem_taskexecutionitem_creator_85"
  add_foreign_key "task_actions", "users", name: "fk_taskexecutionitem_user"
  add_foreign_key "task_actions_users", "task_actions"
  add_foreign_key "task_actions_users", "users"
  add_foreign_key "task_templates", "users"
  add_foreign_key "tasks", "activities", column: "completed_in_activity_id", name: "fk_taskexecution_taskexecution_activitystop_82"
  add_foreign_key "tasks", "activities", column: "started_in_activity_id", name: "fk_taskexecution_taskexecution_activitystart_81"
  add_foreign_key "tasks", "aircrafts", name: "fk_taskexecution_taskexecution_aircraft_84"
  add_foreign_key "tasks", "task_templates", name: "fk_taskexecution_taskexecution_taskcard_83"
  add_foreign_key "tasks", "users", column: "created_by_id", name: "fk_taskexecution_taskexecution_creator_80"
  add_foreign_key "tasks", "users", name: "fk_taskexecution_user"
  add_foreign_key "transfers", "activities", name: "fk_transaction_activity"
  add_foreign_key "transfers", "stock_items", name: "fk_transaction_transaction_stockitem_93"
  add_foreign_key "transfers", "stock_locations", column: "destination_stock_location_id", name: "fk_transaction_transaction_destination_95"
  add_foreign_key "transfers", "stock_locations", column: "source_stock_location_id", name: "fk_transaction_transaction_source_94"
  add_foreign_key "transfers", "users", column: "created_by_id", name: "fk_transaction_user"
  add_foreign_key "transfers", "users", column: "received_by_id", name: "fk_transaction_transaction_receiver_92"
  add_foreign_key "transfers", "users", column: "sent_by_id", name: "fk_transaction_transaction_shipper_91"
  add_foreign_key "users", "airlines", column: "default_airline_id", name: "fk_user_user_airline_98"
  add_foreign_key "users", "archivals"
  add_foreign_key "users", "profiles"
  add_foreign_key "users", "stations", column: "home_station_id"
  add_foreign_key "users", "users", column: "manager_id", name: "fk_user_manager_user_id_106"
end
