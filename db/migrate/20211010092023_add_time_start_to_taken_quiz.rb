class AddTimeStartToTakenQuiz < ActiveRecord::Migration[6.1]
  def change
    add_column :taken_quizzes, :time_start, :timestamp
  end
end
