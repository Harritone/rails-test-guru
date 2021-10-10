class AddSuccessToTakenQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :taken_quizzes, :success, :boolean, default: false
  end
end
