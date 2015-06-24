class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.references :field, index: true
      t.string :tags
      t.integer :votes
      t.datetime :date
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :users
    add_index :questions, [:user_id, :created_at]

    add_foreign_key :questions, :fields
    add_index :questions, [:field_id, :created_at]
  end
end
