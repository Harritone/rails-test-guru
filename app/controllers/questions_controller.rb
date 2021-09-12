class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy]
  before_action :set_quiz, except: %i[show destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @questions = @quiz.questions
    template = <<~HEREDOC
      <h1>List of Questions:</h1>
      <ul>
        <% @questions.each do |question| %>
          <li>
            <%= link_to question.body, question_path(question.id) %>
            <p><%= link_to 'Delete question', question, method: :delete %>
          </li>
        <% end %>
      </ul>
      <%= link_to 'Add question', new_quiz_question_path %>
    HEREDOC

    render inline: template
  end

  def show
    render inline: <<~HEREDOC
      <%= link_to 'Back', quiz_questions_path(#{@question.quiz.id}) %>
      <p><%= @question.body %></p>
    HEREDOC
  end

  def new
    @question = Question.new
  end

  def create
    @question = @quiz.questions.build(question_params)
    if @question.save
      redirect_to quiz_questions_path, notice: 'Question was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to quiz_questions_path
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
    params.require(:question).permit(:body, :quiz_id)
  end
end
