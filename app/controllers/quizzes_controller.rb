class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz, only: :start

  def index
    @quizzes = Quiz.all
  end

  def start
    current_user.quizzes << @quiz
    redirect_to quiz_passage_path(current_user.quiz_passage(@quiz))
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end
end
