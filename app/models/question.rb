class Question < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  has_many :answers, inverse_of: :question, dependent: :destroy
  has_many :taken_quizzes, foreign_key: :current_question_id, dependent: :nullify
  has_many :gists, dependent: :destroy

  validates :body, presence: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
