class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[show update edit destroy start]
  before_action :set_user, only: :start
  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to @quiz
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quiz.update
      redirect_to @quiz
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_path
  end

  def start
    @user.quizzes << @quiz
    redirect_to quiz_passage_path(@user.quiz_passage(@quiz))
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_user
    @user = User.first
  end
end
