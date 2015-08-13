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

ActiveRecord::Schema.define(version: 20150812225605) do

  create_table "answer_votes", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.integer  "vector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "answer_votes", ["answer_id", "user_id"], name: "index_answer_votes_on_answer_id_and_user_id", unique: true
  add_index "answer_votes", ["answer_id"], name: "index_answer_votes_on_answer_id"
  add_index "answer_votes", ["user_id"], name: "index_answer_votes_on_user_id"

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.integer  "votes",       default: 0
    t.boolean  "best",        default: false
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "banned_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "banned_users", ["topic_id"], name: "index_banned_users_on_topic_id"
  add_index "banned_users", ["user_id", "topic_id"], name: "index_banned_users_on_user_id_and_topic_id", unique: true
  add_index "banned_users", ["user_id"], name: "index_banned_users_on_user_id"

  create_table "closed_posts", force: :cascade do |t|
    t.integer  "forum_admin_id"
    t.string   "reason"
    t.integer  "post_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "closed_posts", ["forum_admin_id"], name: "index_closed_posts_on_forum_admin_id"
  add_index "closed_posts", ["post_id"], name: "index_closed_posts_on_post_id"

  create_table "closings", force: :cascade do |t|
    t.integer  "moderator_id"
    t.integer  "question_id"
    t.string   "reason"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "closings", ["moderator_id"], name: "index_closings_on_moderator_id"
  add_index "closings", ["question_id"], name: "index_closings_on_question_id"

  create_table "field_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "field_subscriptions", ["field_id"], name: "index_field_subscriptions_on_field_id"
  add_index "field_subscriptions", ["user_id", "field_id"], name: "index_field_subscriptions_on_user_id_and_field_id", unique: true
  add_index "field_subscriptions", ["user_id"], name: "index_field_subscriptions_on_user_id"

  create_table "fields", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forum_admins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "forum_admins", ["topic_id"], name: "index_forum_admins_on_topic_id"
  add_index "forum_admins", ["user_id", "topic_id"], name: "index_forum_admins_on_user_id_and_topic_id", unique: true
  add_index "forum_admins", ["user_id"], name: "index_forum_admins_on_user_id"

  create_table "moderators", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "moderators", ["field_id", "user_id"], name: "index_moderators_on_field_id_and_user_id", unique: true
  add_index "moderators", ["field_id"], name: "index_moderators_on_field_id"
  add_index "moderators", ["user_id"], name: "index_moderators_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "desc",       null: false
    t.integer  "model_id",   null: false
    t.boolean  "seen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.datetime "date"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "question_votes", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "vector"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "question_votes", ["question_id", "user_id"], name: "index_question_votes_on_question_id_and_user_id", unique: true
  add_index "question_votes", ["question_id"], name: "index_question_votes_on_question_id"
  add_index "question_votes", ["user_id"], name: "index_question_votes_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "field_id"
    t.string   "tags"
    t.integer  "votes",      default: 0
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "url"
    t.boolean  "best",       default: false
  end

  add_index "questions", ["field_id", "created_at"], name: "index_questions_on_field_id_and_created_at"
  add_index "questions", ["field_id"], name: "index_questions_on_field_id"
  add_index "questions", ["user_id", "created_at"], name: "index_questions_on_user_id_and_created_at"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "content"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["post_id"], name: "index_replies_on_post_id"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "general",    default: false
    t.string   "url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "admin",             default: false
    t.integer  "rep",               default: 1
    t.string   "signature"
    t.string   "avatar"
    t.string   "about"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
