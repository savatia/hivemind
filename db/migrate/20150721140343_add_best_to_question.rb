class AddBestToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :best, :boolean, default: false
  end
end
