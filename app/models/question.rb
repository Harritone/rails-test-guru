class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy

  validates :body, presence: true

  scope :by_quiz, ->(quiz) { where(quiz: quiz) }
end
