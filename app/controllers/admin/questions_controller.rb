class Admin::QuestionsController < Admin::BaseController
  before_action :set_question, only: %i[show destroy edit update]
  before_action :set_quiz, only: %i[new create]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def show
  end

  def new
    @question = @quiz.questions.build
    @question.answers.build
  end

  def edit
    @quiz_for_header = @question.quiz
    @question.answers.build
  end

  def update
    @quiz_for_header = @question.quiz
    if @question.update(question_params)
      redirect_to admin_quiz_path(@question.quiz), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @question = @quiz.questions.build(question_params)
    if @question.save
      redirect_to admin_quiz_path(@quiz), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    quiz = @question.quiz
    @question.destroy
    redirect_to admin_quiz_path(quiz), notice: t('.success')
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
    params.require(:question).permit(:body, answers_attributes: [:id, :body, :correct, :_destroy])
  end
end
