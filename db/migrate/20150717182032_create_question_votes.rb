class CreateQuestionVotes < ActiveRecord::Migration
  def change
    create_table :question_votes do |t|
      t.references :question, index: true
      t.references :user, index: true
      t.integer :vector

      t.timestamps null: false
    end
    add_foreign_key :question_votes, :questions
    add_foreign_key :question_votes, :users
    add_index :question_votes, [:question_id, :user_id], :unique => true
  end
end
