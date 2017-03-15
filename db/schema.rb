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

ActiveRecord::Schema.define(version: 20170315052742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_groups", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "base_code",   null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["base_code"], name: "index_account_groups_on_base_code", using: :btree
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "name",                                                     null: false
    t.integer  "code",                                                     null: false
    t.integer  "order",                                                    null: false
    t.boolean  "active",                                   default: true,  null: false
    t.text     "description"
    t.integer  "created_by_id",                                            null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "initial_balance", precision: 12, scale: 2, default: "0.0", null: false
    t.integer  "kind",                                     default: 0,     null: false
    t.index ["created_by_id"], name: "index_accounts_on_created_by_id", using: :btree
    t.index ["order"], name: "index_accounts_on_order", using: :btree
  end

  create_table "journal_entries", force: :cascade do |t|
    t.integer  "created_by_id",             null: false
    t.text     "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.date     "date",                      null: false
    t.integer  "state",         default: 0, null: false
    t.index ["created_by_id"], name: "index_journal_entries_on_created_by_id", using: :btree
    t.index ["state"], name: "index_journal_entries_on_state", using: :btree
  end

  create_table "journal_entry_items", force: :cascade do |t|
    t.integer  "journal_entry_id",                                          null: false
    t.integer  "account_id",                                                null: false
    t.boolean  "normal_side",                               default: true,  null: false
    t.decimal  "amount",           precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.index ["account_id"], name: "index_journal_entry_items_on_account_id", using: :btree
    t.index ["journal_entry_id"], name: "index_journal_entry_items_on_journal_entry_id", using: :btree
  end

  create_table "ledger_entries", force: :cascade do |t|
    t.integer  "journal_entry_item_id",                                          null: false
    t.decimal  "balance",               precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.index ["journal_entry_item_id"], name: "index_ledger_entries_on_journal_entry_item_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "password_digest", default: "", null: false
  end

  add_foreign_key "accounts", "users", column: "created_by_id"
  add_foreign_key "journal_entries", "users", column: "created_by_id"
  add_foreign_key "journal_entry_items", "accounts"
  add_foreign_key "journal_entry_items", "journal_entries"
  add_foreign_key "ledger_entries", "journal_entry_items"
end
