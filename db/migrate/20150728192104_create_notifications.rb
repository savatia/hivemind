class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, null:false
      t.string :desc,  null:false
      t.integer :model_id, null:false
      t.boolean :seen, defaut:false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end
