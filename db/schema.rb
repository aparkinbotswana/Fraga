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

ActiveRecord::Schema.define(version: 20170810044617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "score",            default: 0
  end

  create_table "posts", force: :cascade do |t|
    t.text     "question"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.boolean  "active"
    t.text     "emjoi"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "location"
    t.integer  "score",      default: 0
  end

  create_table "users", force: :cascade do |t|
    t.text     "username"
    t.string   "password_digest"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "is_admin"
    t.string   "location"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "post_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "upvote",     default: 0
    t.integer  "downvote",   default: 0
    t.integer  "comment_id"
  end

end
