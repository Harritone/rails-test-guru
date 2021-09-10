class AddUniqueIndexToQuizTitleLevelScope < ActiveRecord::Migration[6.1]
  def change
     add_index :quizzes, [:title, :level], unique: true
  end
end
