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

ActiveRecord::Schema.define(version: 20151222140149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_details", force: :cascade do |t|
    t.string   "bank_name"
    t.string   "branch_name"
    t.text     "address"
    t.string   "city"
    t.string   "account_number"
    t.integer  "employee_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "pin_code"
    t.string   "city"
    t.integer  "mobile"
    t.date     "dob"
    t.string   "degignation"
    t.string   "gender"
    t.date     "date_of_joining"
    t.integer  "orgnization_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "password"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "message"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orgnizations", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.integer  "phone"
    t.text     "address"
    t.string   "state"
    t.string   "domain"
    t.string   "country"
    t.string   "pin_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "salary_infos", force: :cascade do |t|
    t.integer  "employee_id"
    t.float    "basic"
    t.float    "hra"
    t.float    "provident_fund"
    t.float    "proffesional_tax"
    t.float    "gross_earning"
    t.float    "gross_deduction"
    t.float    "net_pay"
    t.float    "esic"
    t.integer  "extra"
    t.integer  "working_days"
    t.date     "month"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
