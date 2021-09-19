class AddQuestionsCountToQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :questions_count, :integer, default: 0, null: false
  end
end
