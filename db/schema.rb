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

ActiveRecord::Schema.define(version: 20140516145100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comment_images", force: true do |t|
    t.integer  "comment_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_images", ["comment_id"], name: "index_comment_images_on_comment_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "username"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "remote_posts", force: true do |t|
    t.integer  "comment_id"
    t.string   "source"
    t.string   "title"
    t.string   "h1"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remote_posts", ["comment_id"], name: "index_remote_posts_on_comment_id", using: :btree

end
