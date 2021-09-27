# Preview all emails at http://localhost:3000/rails/mailers/quiz_mailer
class QuizMailerPreview < ActionMailer::Preview
  def completed_quiz
    taken_quiz = TakenQuiz.new(user: User.first, quiz: Quiz.first)
    QuizMailer.completed_quiz(taken_quiz)
  end
end
