class AddTimerToQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :duration, :integer, default: 0
  end
end
