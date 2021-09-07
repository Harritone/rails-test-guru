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
  categories = %w[English Welsh American]
  quiz_titles = %w[Grammar Phonetic Listening]

  categories.each do |title|
    category = Category.new(title: title)
    category.save!

    quiz_titles.each_with_index do |qt, i|
      quiz = Quiz.new(title: qt,
                      level: i + 1, category: category,
                      creator: users.sample)
      quiz.save!
      quizzes << quiz
    end
  end

  Quiz.all.each do |quiz|
    questions = []
    5.times { questions << Faker::Science.modifier }
    questions.each do |q|
      Question.create(body: q, quiz: quiz)
    end
  end

  Question.all.each do |question|
    answers = []
    4.times { answers << Faker::Lorem.sentence }

    answers.each { |answer| Answer.create(body: answer, question: question) }
    question.answers.sample.update(correct: true)
  end
end
