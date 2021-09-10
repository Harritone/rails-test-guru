class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy]
  before_action :set_quiz, only: %i[index new]
  skip_before_action :verify_authenticity_token, only: %i[create destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @questions = Question.by_quiz(@quiz)
    template = <<~HEREDOC
      <h1>List of Questions:</h1>
      <ul>
        <% @questions.each do |question| %>
          <li>
            <form action="/quizzes/#{@quiz.id}/questions/<%= question.id %>" method="POST">
              <p><%= question.body %></p>
              <button type="submit">Delete Question</button>
            </form>
          </li>
        <% end %>
      </ul>
    HEREDOC
    respond_to do |format|
      format.html { render inline: template }
      format.json { render json: @questions }
    end
  end

  def show
    respond_to do |format|
      format.html { render inline: '<p><%= @question.body %></p>' }
      format.json { render json: @question }
    end
  end

  def new
    template = <<~HEREDOC
      <h1>Create Question</h1>
      <form action="/quizzes/#{@quiz.id}/questions" method="POST">
        <label for="question_body">Question Body<label>
        <textarea name="body" id="question_body" rows="5"></textarea>
        <input type="hidden" value="#{@quiz.id}" name="quiz_id">
        <button type="submit">Add Question</button>
      </form>
    HEREDOC

    render inline: template
  end

  def create
    question = Question.new(question_params)
    question.save!
    redirect_to quiz_questions_path
  end

  def destroy
    @question.destroy!
    redirect_to quiz_questions_path
  end

  private

  def handle_record_not_found
    render plain: "Sorry, the question you are looking for doesn't exists."
  end

  def set_question
    @question = Question.by_quiz(params[:quiz_id]).find(params[:id])
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.permit(:body, :quiz_id)
  end
end
