class CreateBannedUsers < ActiveRecord::Migration
  def change
    create_table :banned_users do |t|
      t.references :user, index: true, presence: true
      t.references :topic, index: true, presence: true

      t.timestamps null: false
    end
    add_foreign_key :banned_users, :users
    add_foreign_key :banned_users, :topics
    add_index :banned_users, [:user_id, :topic_id], unique: true
  end
end
