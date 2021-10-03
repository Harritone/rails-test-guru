class Question < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  has_many :answers, dependent: :destroy
  has_many :taken_quizzes, foreign_key: :current_question_id, dependent: :nullify
  has_many :gists, dependent: :destroy

  validates :body, presence: true
end
