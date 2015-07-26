class AddGeneralToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :general, :boolean, default: false
  end
end
