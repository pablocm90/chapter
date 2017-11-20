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

ActiveRecord::Schema.define(version: 20171120104725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "nom_de_plume"
    t.string   "bank_account"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_authors_on_user_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "genre"
    t.string   "tags"
    t.string   "cover_pic"
    t.string   "quote_hover"
    t.string   "content_pdf"
    t.string   "content_epub"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_books_on_author_id", using: :btree
  end

  create_table "episodes", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "description"
    t.string   "content_pdf"
    t.string   "content_epub"
    t.string   "number"
    t.integer  "book_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "price_cents",  default: 0, null: false
    t.float    "price"
    t.index ["book_id"], name: "index_episodes_on_book_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "state"
    t.string   "topup_sku"
    t.integer  "amount_cents", default: 0, null: false
    t.jsonb    "payment"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "registrations", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.index ["email"], name: "index_registrations_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_registrations_on_reset_password_token", unique: true, using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "content"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "topups", force: :cascade do |t|
    t.string   "sku"
    t.string   "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "price_cents", default: 0, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "episode_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_transactions_on_book_id", using: :btree
    t.index ["episode_id"], name: "index_transactions_on_episode_id", using: :btree
    t.index ["user_id"], name: "index_transactions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "picture"
    t.string   "description"
    t.boolean  "active"
    t.boolean  "is_author",       default: false
    t.string   "fav_genre"
    t.string   "f_name"
    t.string   "l_name"
    t.integer  "registration_id"
    t.boolean  "status"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "tokens"
    t.index ["registration_id"], name: "index_users_on_registration_id", using: :btree
  end

  add_foreign_key "authors", "users"
  add_foreign_key "books", "authors"
  add_foreign_key "episodes", "books"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "transactions", "books"
  add_foreign_key "transactions", "episodes"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "registrations"
end
