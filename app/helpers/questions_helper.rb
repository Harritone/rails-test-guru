module QuestionsHelper
  def question_header(quiz, question)
    title = question.new_record? ? Constants::TITLES[:new] : Constants::TITLES[:edit]
    "#{title} #{quiz.title} question."
  end
end
