class AddUrlToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :url, :string, unique: true
  end
end
