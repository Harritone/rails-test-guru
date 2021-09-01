class User < ApplicationRecord
  has_many :taken_quizzes
  has_many :quizzes, through: :taken_quizzes

  def taken_quizzes_by_level(level)
    Quiz.joins(:taken_quizzes).where('taken_quizzes.user_id': id, level: level)
  end
end
