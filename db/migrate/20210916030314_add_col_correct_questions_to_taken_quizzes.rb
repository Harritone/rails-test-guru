class AddColCorrectQuestionsToTakenQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :taken_quizzes, :correct_questions, :integer, default: 0
  end
end
