ActiveRecord::Base.transaction do
  TakenQuiz.destroy_all
  User.destroy_all
  Answer.destroy_all
  Question.destroy_all
  Quiz.destroy_all
  Category.destroy_all

  5.times do
    category = Category.new(title: Faker::Science.science)
    category.save!
    5.times do |i|
      quiz = Quiz.new(title: Faker::Science.element_subcategory, 
                      level: i+1, category_id: category.id)
      quiz.save!

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
      end
    end
  end

  3.times do
    user = User.new(email: Faker::Internet.email)
    user.save!
  end

  user = User.order(Arel.sql('RANDOM()')).first
  quiz = Quiz.order(Arel.sql('RANDOM()')).first
  taken_quiz = TakenQuiz.new(user_id: user.id, quiz_id: quiz.id)
  taken_quiz.save
end
