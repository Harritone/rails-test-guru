class ApplicationMailer < ActionMailer::Base
  default from: %{"QuizGuru" <mail@quizguru.com>}
  layout 'mailer'
end
