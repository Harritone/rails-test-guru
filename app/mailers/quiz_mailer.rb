class QuizMailer < ApplicationMailer
  def completed_quiz(quiz_passage)
    @user = quiz_passage.user
    @quiz = quiz_passage.quiz

    mail to: @user.email, subject: "You've completed the QuizGuru quiz!"
  end
end
