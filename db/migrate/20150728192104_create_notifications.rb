class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.string :type
      t.id :type
      t.boolean :seen

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end
