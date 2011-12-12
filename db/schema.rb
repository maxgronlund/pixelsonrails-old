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

ActiveRecord::Schema.define(:version => 20111212223652) do

  create_table "case_images", :force => true do |t|
    t.string   "image"
    t.text     "crop_params"
    t.integer  "case_study_id"
    t.text     "image_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "border"
  end

  add_index "case_images", ["case_study_id"], :name => "index_case_images_on_case_study_id"

  create_table "case_studies", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.text     "crop_params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "task"
    t.string   "year"
    t.string   "client"
    t.string   "sorting"
    t.text     "image_text"
  end

  create_table "gallery_images", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.text     "crop_params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sorting"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.string   "image_file"
    t.text     "crop_params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text_contents", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identity"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                  :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128,  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "role"
    t.string   "image"
    t.string   "crop_params",            :limit => 1024
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "grid"
    t.string   "title"
    t.text     "body"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
