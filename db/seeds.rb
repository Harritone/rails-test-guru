# Please don't make me make up quizzes and questions) It's very hard for me( and takes a tremendous amount of time(
ActiveRecord::Base.transaction do
  TakenQuiz.destroy_all
  User.destroy_all
  Answer.destroy_all
  Question.destroy_all
  Quiz.destroy_all
  Category.destroy_all

  categories = %w[English Welsh American]
  quiz_titles = %w[Grammar Phonetic Listening]
  quizzes = []
  users = []
  questions = []
  ques_titles = []
  answers = []

  3.times do
    user = User.new(email: Faker::Internet.email)
    user.save!
    users << user
  end

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

  quizzes.each do |quiz|
    5.times { ques_titles << "#{Faker::Science.modifier}" }
    ques_titles.uniq.each do |body|
      questions << Question.create(body: body, quiz: quiz)
    end
  end

  4.times { answers << Faker::Lorem.sentence }
  questions.each do |question|
    answers.each { |answer| Answer.create(body: answer, question: question, correct: false) }
    question.answers.sample.update!(correct: true)
    # question.save!
  end
end
