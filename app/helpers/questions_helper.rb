module QuestionsHelper
  TITLES = { new: 'Create New', edit: 'Edit', show: nil }.freeze
  def question_header(quiz)
    "#{TITLES[action_name.to_sym]} #{quiz.title} question."
  end
end
