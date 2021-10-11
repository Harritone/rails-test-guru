class TakenQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_taken_quiz, only: %i[show result update gist]

  def show
    @time_left = @taken_quiz.time_left
  end

  def result
  end

  def update
    @taken_quiz.accept!(params[:answer_ids])
    if @taken_quiz.completed? || @taken_quiz.has_no_time_to_proceed?
      QuizMailer.completed_quiz(@taken_quiz).deliver_now if @taken_quiz.completed?
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
