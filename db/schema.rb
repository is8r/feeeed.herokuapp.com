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

ActiveRecord::Schema.define(version: 2014_03_31_011209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clicks", id: :serial, force: :cascade do |t|
    t.integer "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "post_id"
    t.index ["post_id"], name: "index_clicks_on_post_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.text "url"
    t.text "url_original"
    t.datetime "posted_at"
    t.text "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "site_id"
    t.index ["site_id"], name: "index_posts_on_site_id"
  end

  create_table "sites", id: :serial, force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.text "rss"
    t.boolean "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "category_id"
    t.integer "cid"
    t.index ["category_id"], name: "index_sites_on_category_id"
  end

end
