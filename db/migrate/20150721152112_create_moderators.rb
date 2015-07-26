class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.references :user, index: true
      t.references :field, index: true

      t.timestamps null: false
    end
    add_foreign_key :moderators, :users
    add_foreign_key :moderators, :fields
    add_index :moderators, [:field_id, :user_id], unique: true
  end
end
