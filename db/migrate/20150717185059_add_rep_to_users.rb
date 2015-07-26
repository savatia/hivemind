class AddRepToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rep, :integer, default: 1
  end
end
