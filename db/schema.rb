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

ActiveRecord::Schema.define(version: 20131118080220) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "register"
    t.string   "ic"
    t.string   "dic"
    t.string   "adress"
    t.string   "bank_account"
    t.string   "hdp"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_name"
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "PSC"
    t.string   "IBAN"
    t.string   "SWIFT"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "client_id"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "var_symbol"
    t.string   "konst_symbol"
    t.integer  "numb_invoice"
    t.date     "date_of_issue"
    t.date     "date_of_the_chargeable_event"
    t.date     "due_date"
    t.date     "payment_date"
    t.float    "total_price"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree

  create_table "pieces", force: true do |t|
    t.text     "text"
    t.float    "number_piece"
    t.float    "price_piece"
    t.float    "DPH"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_price_piece"
  end

  add_index "pieces", ["invoice_id"], name: "index_pieces_on_invoice_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "register"
    t.string   "ic"
    t.string   "dic"
    t.string   "adress"
    t.string   "bank_account"
    t.string   "dph"
    t.string   "business_name"
    t.string   "street"
    t.string   "street2"
    t.string   "city"
    t.string   "PSC"
    t.string   "IBAN"
    t.string   "SWIFT"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
