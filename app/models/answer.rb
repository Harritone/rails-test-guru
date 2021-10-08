class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :number_of_answers_for_question 

  scope :correct, -> { where(correct: true) }

  scope :correct_for_quiz, ->(quiz_id) { correct.joins(:question).where(questions: { quiz_id: quiz_id })}

  def number_of_answers_for_question
    count = self.question.answers.count
    @errors.add(:answer, I18n.t('activerecord.errors.messages.answers_cnt')) if count > (self.new_record? ? 3 : 4)
  end
end
