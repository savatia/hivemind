class CreateFieldSubscriptions < ActiveRecord::Migration
  def change
    create_table :field_subscriptions do |t|
      t.references :user, index: true, presence: true
      t.references :field, index: true, presence: true

      t.timestamps null: false
    end
    add_foreign_key :field_subscriptions, :users
    add_foreign_key :field_subscriptions, :fields
    add_index :field_subscriptions, [:user_id, :field_id], unique: true
  end
end
