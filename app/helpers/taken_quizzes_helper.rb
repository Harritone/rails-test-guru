module TakenQuizzesHelper
  def passage_percentage_class(taken_quiz)
    taken_quiz.success? ? 'success' : 'danger'
  end
end
