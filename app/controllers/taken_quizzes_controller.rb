class TakenQuizzesController < ApplicationController
  before_action :set_taken_quiz, only: %i[show result update]
  def show
    redirect_to result_quiz_passage_path(@taken_quiz) if @taken_quiz.completed?
  end

  def result
  end

  def update
    @taken_quiz.accept!(params[:answer_ids])
    if @taken_quiz.completed?
      redirect_to result_quiz_passage_path(@taken_quiz)
    else
      render :show
    end
  end

  private

  def set_taken_quiz
    @taken_quiz = TakenQuiz.find(params[:id])
  end
end
