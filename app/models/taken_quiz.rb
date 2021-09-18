class TakenQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :current_question, class_name: 'Question',
                                optional: true,
                                foreign_key: :current_question_id

  before_validation :set_first_question, on: :create

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    self.current_question = next_question
    save!
  end
  
  def completed?
    self.current_question.nil?
  end

  private

  def set_first_question
    self.current_question = quiz.questions.order(:id).first if quiz.present?
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count
    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    quiz.questions.order(:id).where('id > ?', current_question_id).first
  end
end
