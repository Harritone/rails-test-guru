class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  has_many :taken_quizzes, foreign_key: :current_question_id

  validates :body, presence: true
end
