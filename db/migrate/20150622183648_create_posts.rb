class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :topic, index: true
      t.datetime :date
      t.references :user, index: true
      t.string :title

      t.timestamps null: false
    end
    add_foreign_key :posts, :topics
    add_foreign_key :posts, :users
  end
end
