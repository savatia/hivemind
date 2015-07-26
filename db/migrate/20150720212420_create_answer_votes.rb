class CreateAnswerVotes < ActiveRecord::Migration
  def change
    create_table :answer_votes do |t|
      t.references :answer, index: true
      t.references :user, index: true
      t.integer :vector

      t.timestamps null: false
    end
    add_foreign_key :answer_votes, :answers
    add_foreign_key :answer_votes, :users
    add_index :answer_votes, [:answer_id, :user_id], :unique => true
  end
end
