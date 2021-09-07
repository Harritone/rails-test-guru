class ChangeQuizzesUniqIndexScope < ActiveRecord::Migration[6.1]
  def change
    remove_index :quizzes, [:title, :level]
    add_index :quizzes, [:title, :level, :category_id], unique: true
  end
end
