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

ActiveRecord::Schema.define(version: 20151116073326) do

  create_table "sprite_cities", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "prefecture_id", limit: 2
    t.string   "code",          limit: 255
    t.integer  "is_ward",       limit: 1,   default: 0
    t.integer  "is_other",      limit: 1,   default: 0
    t.integer  "sequence",      limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprite_contents", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "type",           limit: 255
    t.string   "slug",           limit: 255
    t.text     "note",           limit: 65535
    t.string   "ancestry",       limit: 255
    t.integer  "parented_id",    limit: 3
    t.integer  "ancestry_depth", limit: 4,     default: 0
    t.integer  "position",       limit: 2
    t.boolean  "is_directory",                 default: false
    t.string   "status",         limit: 255,   default: "private", null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "sprite_contents", ["ancestry"], name: "index_sprite_contents_on_ancestry", using: :btree
  add_index "sprite_contents", ["slug"], name: "index_sprite_contents_on_slug", using: :btree

  create_table "sprite_item_item_categories", force: :cascade do |t|
    t.integer  "item_id",          limit: 4
    t.integer  "item_category_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "sprite_item_locations", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.integer  "city_id",    limit: 4
    t.string   "address",    limit: 255
    t.decimal  "lat",                    precision: 10, scale: 6
    t.decimal  "lng",                    precision: 10, scale: 6
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "sprite_items", force: :cascade do |t|
    t.string   "title",       limit: 255,                       null: false
    t.string   "url",         limit: 255,                       null: false
    t.text     "description", limit: 65535
    t.text     "body",        limit: 65535
    t.text     "free_space1", limit: 65535
    t.text     "free_space2", limit: 65535
    t.datetime "pub_date"
    t.datetime "mod_date"
    t.datetime "exp_date"
    t.integer  "pr_flg",      limit: 1,     default: 0
    t.string   "pr_title",    limit: 255
    t.string   "pr_url",      limit: 255
    t.string   "address",     limit: 255
    t.string   "status",      limit: 255,   default: "private", null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "sprite_prefectures", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
