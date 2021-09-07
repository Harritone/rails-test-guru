class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :number_of_answers_for_question

  scope :correct, -> { where(correct: true) }

  def number_of_answers_for_question
    cnt = self.question.answers.count
    errors.add(:answer, "more than 4 answers aren't allowed") if cnt > 4
  end
end
