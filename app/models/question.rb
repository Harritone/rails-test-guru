class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy

  validate :number_of_answers

  def number_of_answers
    cnt = answers.count
    errors.add(:question, 'should have at least 1 answer') if cnt.zero?
    errors.add(:question, "more than 4 answers aren't allowed") if cnt > 4
  end
end
