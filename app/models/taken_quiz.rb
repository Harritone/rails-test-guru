class TakenQuiz < ApplicationRecord
  SUCCESS_PERSENTAGE = 85
  MILISECONDS_IN_A_SECOND = 1_000
  REAL_BIG_TIME_PERIOD = 10_000
  SECONDS_IN_A_MINUTE = 60

  belongs_to :user
  belongs_to :quiz
  belongs_to :current_question, class_name: 'Question',
                                optional: true,
                                foreign_key: :current_question_id

  before_validation :next_question

  def time_left
    return REAL_BIG_TIME_PERIOD unless self.quiz.with_timer?

    ((self.quiz.duration * SECONDS_IN_A_MINUTE * MILISECONDS_IN_A_SECOND) - (updated_at - created_at)) / MILISECONDS_IN_A_SECOND
  end

  def has_no_time_to_proceed?
    self.time_left <= MILISECONDS_IN_A_SECOND
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def success?
    success_percentage >= SUCCESS_PERSENTAGE && self.completed?
  end

  def success_percentage
    (100.0 / quiz.questions_count * correct_questions).to_i 
  end

  def passage_percentage
    100 / quiz.questions_count * amount_questions_passed
  end

  def completed?
    self.current_question.nil?
  end

  def amount_questions_passed
    quiz.questions.where('id < ?', current_question.id).count
  end

  private

  def set_first_question
    quiz.questions.order(:id).first
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count
    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
      correct_answers_count == (answer_ids&.count || 0)
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    self.current_question =
      if new_record?
        set_first_question
      else
        quiz.questions.order(:id).where('id > ?', current_question_id).first
      end
  end
end
