class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.references :question, index: true
      t.integer :votes, default:0
      t.boolean :best, default: false
      t.references :user, index: true
      t.datetime :date

      t.timestamps null: false
    end
    add_foreign_key :answers, :questions
    add_foreign_key :answers, :users
  end
end
