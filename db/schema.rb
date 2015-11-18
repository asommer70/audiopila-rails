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

ActiveRecord::Schema.define(version: 20151118193304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.date     "year"
    t.string   "artist"
    t.string   "genre"
    t.integer  "audios"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image_uid"
    t.string   "image_name"
    t.string   "image"
    t.integer  "current_audio"
  end

  add_index "albums", ["audios"], name: "index_albums_on_audios", using: :btree

  create_table "albums_audios", force: :cascade do |t|
    t.integer "album_id"
    t.integer "audio_id"
  end

  add_index "albums_audios", ["album_id"], name: "index_albums_audios_on_album_id", using: :btree
  add_index "albums_audios", ["audio_id"], name: "index_albums_audios_on_audio_id", using: :btree

  create_table "audios", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.string   "path"
    t.integer  "playback_time"
    t.integer  "album_id"
    t.integer  "album_order"
  end

  add_index "audios", ["name"], name: "index_audios_on_name", using: :btree

  create_table "audios_playlists", id: false, force: :cascade do |t|
    t.integer "audio_id",    null: false
    t.integer "playlist_id", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image"
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "current_audio"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

end
