class CreateForumAdmins < ActiveRecord::Migration
  def change
    create_table :forum_admins do |t|
      t.references :user, index: true, presence: true
      t.references :topic, index: true, presence: true

      t.timestamps null: false
    end
    add_foreign_key :forum_admins, :users
    add_foreign_key :forum_admins, :topics
    add_index :forum_admins, [:user_id, :topic_id], unique: true
  end
end
