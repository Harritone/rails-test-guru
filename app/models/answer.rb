class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :number_of_answers_for_question

  scope :all_correct, -> { where(correct: true) }

  def number_of_answers_for_question
    cnt = question.answers.count
    errors.add(:question, "more than 4 answers aren't allowed") if cnt > 4
  end
end
