# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_09_190652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "analytics_events", force: :cascade do |t|
    t.string "url", null: false
    t.string "goal", null: false
    t.integer "value", default: 0, null: false
    t.datetime "tracked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "contact_name", null: false
    t.string "company", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio", null: false
    t.integer "developer_notifications", default: 0, null: false
    t.string "website"
    t.string "contact_role"
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "developer_id"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "developer_blocked_at"
    t.datetime "business_blocked_at"
    t.index ["business_id"], name: "index_conversations_on_business_id"
    t.index ["developer_id"], name: "index_conversations_on_developer_id"
  end

  create_table "developers", force: :cascade do |t|
    t.string "name", null: false
    t.date "available_on"
    t.string "hero", null: false
    t.text "bio", null: false
    t.string "website"
    t.string "github"
    t.string "twitter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "linkedin"
    t.integer "search_status"
    t.integer "preferred_min_hourly_rate"
    t.integer "preferred_max_hourly_rate"
    t.integer "preferred_min_salary"
    t.integer "preferred_max_salary"
    t.virtual "textsearchable_index_col", type: :tsvector, as: "to_tsvector('simple'::regconfig, (((COALESCE(hero, ''::character varying))::text || ' '::text) || COALESCE(bio, ''::text)))", stored: true
    t.datetime "featured_at"
    t.boolean "profile_reminder_notifications", default: true
    t.index ["textsearchable_index_col"], name: "textsearchable_index", using: :gin
    t.index ["user_id"], name: "index_developers_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "developer_id"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "country_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "time_zone", null: false
    t.integer "utc_offset", null: false
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_locations_on_developer_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.string "sender_type"
    t.bigint "sender_id"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body_html", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["sender_type", "sender_id"], name: "index_messages_on_sender"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "open_startup_contributions", force: :cascade do |t|
    t.date "occurred_on", null: false
    t.string "description", null: false
    t.string "url"
    t.decimal "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_startup_expenses", force: :cascade do |t|
    t.date "occurred_on", null: false
    t.string "description", null: false
    t.string "url"
    t.decimal "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_startup_metrics", force: :cascade do |t|
    t.date "occurred_on", null: false
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_startup_monthly_balances", force: :cascade do |t|
    t.date "occurred_on", null: false
    t.decimal "revenue", null: false
    t.decimal "expenses", null: false
    t.decimal "contributions", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_startup_revenue", force: :cascade do |t|
    t.date "occurred_on", null: false
    t.string "description", null: false
    t.decimal "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_startup_stripe_transactions", force: :cascade do |t|
    t.string "stripe_id", null: false
    t.decimal "amount", null: false
    t.datetime "created", null: false
    t.string "description", null: false
    t.decimal "fee", null: false
    t.string "transaction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stripe_id"], name: "index_open_startup_stripe_transactions_on_stripe_id"
    t.index ["transaction_type"], name: "index_open_startup_stripe_transactions_on_transaction_type"
  end

  create_table "open_startup_transactions", force: :cascade do |t|
    t.date "occurred_on", null: false
    t.string "description", null: false
    t.string "url"
    t.decimal "amount", null: false
    t.integer "transaction_type", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pay_charges", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_id"
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.string "currency"
    t.integer "application_fee_amount"
    t.integer "amount_refunded"
    t.jsonb "metadata"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_charges_on_customer_id_and_processor_id", unique: true
    t.index ["subscription_id"], name: "index_pay_charges_on_subscription_id"
  end

  create_table "pay_customers", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "deleted_at", "default"], name: "pay_customer_owner_index"
    t.index ["processor", "processor_id"], name: "index_pay_customers_on_processor_and_processor_id", unique: true
  end

  create_table "pay_merchants", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "processor"], name: "index_pay_merchants_on_owner_type_and_owner_id_and_processor"
  end

  create_table "pay_payment_methods", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "processor_id", null: false
    t.boolean "default"
    t.string "type"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_payment_methods_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "name", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.string "status", null: false
    t.datetime "trial_ends_at"
    t.datetime "ends_at"
    t.decimal "application_fee_percent", precision: 8, scale: 2
    t.jsonb "metadata"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_subscriptions_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_webhooks", force: :cascade do |t|
    t.string "processor"
    t.string "event_type"
    t.jsonb "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_levels", force: :cascade do |t|
    t.bigint "developer_id"
    t.boolean "junior"
    t.boolean "mid"
    t.boolean "senior"
    t.boolean "principal"
    t.boolean "c_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_role_levels_on_developer_id", unique: true
  end

  create_table "role_types", force: :cascade do |t|
    t.bigint "developer_id"
    t.boolean "part_time_contract"
    t.boolean "full_time_contract"
    t.boolean "full_time_employment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_role_types_on_developer_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "pay_charges", "pay_customers", column: "customer_id"
  add_foreign_key "pay_charges", "pay_subscriptions", column: "subscription_id"
  add_foreign_key "pay_payment_methods", "pay_customers", column: "customer_id"
  add_foreign_key "pay_subscriptions", "pay_customers", column: "customer_id"
  add_foreign_key "role_levels", "developers"
  add_foreign_key "role_types", "developers"
end
