class User < ApplicationRecord
  # has_many :quiz_passages, class_name: 'Quiz_Passage'
  has_many :taken_quizzes
  has_many :quizzes, through: :taken_quizzes
  has_many :created_quizzes, class_name: 'Quiz',
                             foreign_key: :creator_id,
                             dependent: :nullify

  validates :email, presence: true

  def taken_quizzes_by_level(level)
    Quiz.joins(:taken_quizzes).where('taken_quizzes.user_id': id, level: level)
  end

  def quiz_passage(quiz)
    taken_quizzes.order(id: :desc).find_by(quiz_id: quiz.id)
  end
end
