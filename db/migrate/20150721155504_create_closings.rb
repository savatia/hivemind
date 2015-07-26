class CreateClosings < ActiveRecord::Migration
  def change
    create_table :closings do |t|
      t.references :moderator, index: true
      t.references :question, index: true
      t.string :reason

      t.timestamps null: false
    end
    add_foreign_key :closings, :moderators
    add_foreign_key :closings, :questions
  end
end
