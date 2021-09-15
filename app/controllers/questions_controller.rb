class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy edit update]
  before_action :set_quiz, only: %i[new create]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to quiz_path(@question.quiz)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @question = @quiz.questions.build(question_params)
    if @question.save
      redirect_to quiz_path(@quiz), notice: 'Question was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    quiz = @question.quiz
    @question.destroy
    redirect_to quiz_path(quiz), notice: 'Question was successfully removed.'
  end

  private

  def handle_record_not_found
    render plain: "Sorry, the question you are looking for doesn't exists."
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
