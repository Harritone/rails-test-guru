class Admin::QuizzesController < Admin::BaseController
  before_action :set_quizzes, only: %i[index update_inline]
  before_action :set_quiz, only: %i[show update edit destroy start update_inline]
  before_action :set_categories, only: %i[new edit create]

  def index
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = current_user.created_quizzes.build(quiz_params)
    if @quiz.save
      redirect_to [:admin, @quiz], notice: t('.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to [:admin, @quiz], notice: t('.success')
    else
      render :edit
    end
  end

  def update_inline
    if @quiz.update(quiz_params)
      redirect_to admin_quizzes_path
    else
      render :index
    end
  end

  def destroy
    @quiz.destroy
    redirect_to admin_quizzes_path, notice: t('.success')
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, :level, :category_id)
  end

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def set_quizzes
    @quizzes = Quiz.all
  end

  def set_categories
    @categories = Category.all
  end
end
