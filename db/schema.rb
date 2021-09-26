# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_26_210730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "learnedphrasals", force: :cascade do |t|
    t.bigint "phrasal_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phrasal_id"], name: "index_learnedphrasals_on_phrasal_id"
    t.index ["user_id"], name: "index_learnedphrasals_on_user_id"
  end

  create_table "meanbodies", force: :cascade do |t|
    t.string "synonyms"
    t.string "anthonyms"
    t.string "example"
    t.bigint "meaning_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meaning_id"], name: "index_meanbodies_on_meaning_id"
  end

  create_table "meanings", force: :cascade do |t|
    t.string "definition"
    t.bigint "phrasal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["phrasal_id"], name: "index_meanings_on_phrasal_id"
  end

  create_table "phrasals", force: :cascade do |t|
    t.bigint "verb_id", null: false
    t.bigint "prepadv_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prepadv_id"], name: "index_phrasals_on_prepadv_id"
    t.index ["verb_id"], name: "index_phrasals_on_verb_id"
  end

  create_table "phrases", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.bigint "verb_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["verb_id"], name: "index_phrases_on_verb_id"
  end

  create_table "prepadvs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "successverbs", force: :cascade do |t|
    t.decimal "rate"
    t.bigint "user_id", null: false
    t.bigint "verb_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_successverbs_on_user_id"
    t.index ["verb_id"], name: "index_successverbs_on_verb_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "verbs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "learnedphrasals", "phrasals"
  add_foreign_key "learnedphrasals", "users"
  add_foreign_key "meanbodies", "meanings"
  add_foreign_key "meanings", "phrasals"
  add_foreign_key "phrasals", "prepadvs"
  add_foreign_key "phrasals", "verbs"
  add_foreign_key "phrases", "verbs"
  add_foreign_key "successverbs", "users"
  add_foreign_key "successverbs", "verbs"
end
