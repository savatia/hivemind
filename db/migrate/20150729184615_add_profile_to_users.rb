class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signature, :string
    add_column :users, :avatar, :string
    add_column :users, :about, :string
  end
end
