class SetBadgeService
  def initialize(taken_quizz)
    @taken_quizz = taken_quizz
    @user = taken_quizz.user
    @quiz = taken_quizz.quiz
  end

  def call
    set_badge = nil
    Badge.all.each do |badge|
      if send("#{badge.rule}?")
        assign_badge(badge)
        set_badge = badge
      end
    end
    set_badge
  end

  private

  def assign_badge(badge)
    user_badge = @user.user_badges.find_by(badge: badge)
    if user_badge.present?
      user_badge.update(quantity: user_badge.quantity + 1)
    else
      @user.badges << badge
    end
  end

  def category_complete?
    passed_quizzes_ids = TakenQuiz
                          .by_category_for_user(@quiz.category, @user)
                          .where(success: true)
                          .pluck(:quiz_id)
                          .uniq
    category_quizzes_ids = Quiz
                           .where(category: @quiz.category)
                           .pluck(:id)
    passed_quizzes_ids & category_quizzes_ids == category_quizzes_ids
  end

  def level_complete?
    passed_quizzes_ids = TakenQuiz
                         .by_level_for_user(@quiz.level, @user)
                         .where(success: true)
                         .pluck(:quiz_id)
                         .uniq

    quizzes_by_level_ids = Quiz.where(level: @quiz.level).pluck(:id)

    passed_quizzes_ids & quizzes_by_level_ids == quizzes_by_level_ids
  end

  def first_attempt?
    @user.taken_quizzes.where(quiz: @quiz).count == 1 &&
      @taken_quizz.success
  end

  def finaly?
    @user.taken_quizzes.where(quiz: @quiz).count > 5 &&
      @user.taken_quizzes.where(quiz: @quiz, success: true).count == 1 &&
      @taken_quizz.success
  end
end
