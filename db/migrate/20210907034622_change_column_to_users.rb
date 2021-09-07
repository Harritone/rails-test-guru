class ChangeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :quizzes, :user_id, :integer
    add_reference :quizzes, :creator
  end
end
