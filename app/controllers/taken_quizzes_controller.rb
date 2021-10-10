class TakenQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_taken_quiz, only: %i[show result update gist]

  def show
    redirect_to result_quiz_passage_path(@taken_quiz) if @taken_quiz.completed?
  end

  def result
    @badge = SetBadgeService.new(@taken_quiz).call if @taken_quiz.success?
  end

  def update
    @taken_quiz.accept!(params[:answer_ids])
    if @taken_quiz.completed?
      QuizMailer.completed_quiz(@taken_quiz).deliver_now
      redirect_to result_quiz_passage_path(@taken_quiz)
    else
      render :show
    end
  end

  def gist
    current_question = @taken_quiz.current_question
    result = GistQuestionService.new(current_question).call

    notice = if result.success?
      gist = current_user.gists.create(question: current_question,
                                       url: result.html_url)
      { notice: t('.success_html', url: gist.url) }
    else
      { notice: t('.failure') }
    end

    redirect_to quiz_passage_path(@taken_quiz), notice
  end

  private

  def set_taken_quiz
    @taken_quiz = TakenQuiz.find(params[:id])
  end
end
