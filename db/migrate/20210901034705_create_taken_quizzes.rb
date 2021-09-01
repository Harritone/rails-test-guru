class CreateTakenQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :taken_quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
