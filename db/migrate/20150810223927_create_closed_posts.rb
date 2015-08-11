class CreateClosedPosts < ActiveRecord::Migration
  def change
    create_table :closed_posts do |t|
      t.references :forum_admin, index: true, presence: true
      t.string :reason, presence: true
      t.references :post, index: true, presence: true, unique: true

      t.timestamps null: false
    end
    add_foreign_key :closed_posts, :forum_admins
    add_foreign_key :closed_posts, :posts
  end
end
