module QuestionsHelper
  TITLES = { new: 'Create New', edit: 'Edit' }.freeze
  def question_header(quiz, question)
    title = question.new_record? ? TITLES[:new] : TITLES[:edit]
    "#{title} #{quiz.title} question."
  end
end
