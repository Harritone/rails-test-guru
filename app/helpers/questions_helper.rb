module QuestionsHelper
  TITLES = { new: I18n.t('admin.questions.new.create'), edit: I18n.t('admin.questions.edit.edit') }.freeze

  def question_header(quiz, question)
    title = question.new_record? ? TITLES[:new] : TITLES[:edit]
    "#{title} #{quiz.title} #{I18n.t('admin.question')}."
  end
end
