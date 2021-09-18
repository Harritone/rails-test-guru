class AddCurrentQuestionToTakenQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_reference :taken_quizzes, :current_question
  end
end
