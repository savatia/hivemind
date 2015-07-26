class AddUrlToPost < ActiveRecord::Migration
  def change
    add_column :posts, :url, :string, unique: true, presence: true
  end
end
