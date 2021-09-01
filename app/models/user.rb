class User < ApplicationRecord
  has_many :taken_quizzes

  def taken_quiz_by_level(level)
    User.joins(taken_quizzes: :quiz).where(id: id, 'quizzes.level' => level)
  end
end
