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

ActiveRecord::Schema.define(:version => 20110706115310) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.string   "body"
    t.string   "category"
    t.integer  "sequence"
    t.string   "choices"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "respondents", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",  :default => false
  end

  create_table "trackers", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "respondent_id"
    t.integer  "progress",      :default => 0
    t.boolean  "completed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
