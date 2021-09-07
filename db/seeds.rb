# Please don't make me make up quizzes and questions) It's very hard for me( and takes a tremendous amount of time(
ActiveRecord::Base.transaction do
  TakenQuiz.destroy_all
  User.destroy_all
  Answer.destroy_all
  Question.destroy_all
  Quiz.destroy_all
  Category.destroy_all

  quizzes = []
  users = []

  3.times do
    user = User.new(email: Faker::Internet.email)
    user.save!
    users << user
  end

  5.times do
    category = Category.new(title: Faker::Science.science)
    category.save!
    5.times do |i|
      quiz = Quiz.new(title: Faker::Science.element_subcategory,
                      level: i + 1, category_id: category.id,
                      creator: users.sample)
      quiz.save!
      quizzes << quiz

      5.times do |i|
        question = Question.new(body: Faker::TvShows::SouthPark.quote,
                                quiz_id: quiz.id)
        question.save!

        2.times do |i|
          answer = Answer.new(body: Faker::Science.modifier,
                              question_id: question.id)
          answer.save!
        end
        answer = Answer.new(body: Faker::Science.modifier,
                            correct: true, question_id: question.id)
        answer.save!
        taken_quiz = TakenQuiz.new(user: users.sample, quiz: quizzes.sample)
        taken_quiz.save!
      end
    end
  end

end
