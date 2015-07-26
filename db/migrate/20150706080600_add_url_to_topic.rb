class AddUrlToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :url, :string, unique: true
  end
end
