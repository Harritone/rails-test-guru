class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :number_of_answers_for_question

  scope :correct, -> { where(correct: true) }

  def number_of_answers_for_question
    count = question.answers.count
    @errors.add(:answer, "more than 4 answers aren't allowed") if count > 4
  end
end
