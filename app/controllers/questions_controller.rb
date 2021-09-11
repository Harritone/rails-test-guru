class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy]
  before_action :set_quiz, only: %i[index new create]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    @questions = Quiz.find(params[:quiz_id]).questions
    template = <<~HEREDOC
      <h1>List of Questions:</h1>
      <ul>
        <% @questions.each do |question| %>
          <li>
            <%= link_to question.body, question_path(question.id) %>
            <p><%= question.body %></p>
            <p><%= link_to 'Delete question', question_path(question.id), method: :delete %>
          </li>
        <% end %>
      </ul>
      <%= link_to 'Add question', new_quiz_question_path %>
    HEREDOC

    render inline: template
  end

  def show
    quiz = @question.quiz
    render inline: <<~HEREDOC
      <%= link_to 'Back', quiz_questions_path(#{quiz.id}) %>
      <p><%= @question.body %></p>
    HEREDOC
  end

  def new
    @question = Question.new
    template = <<~HEREDOC
      <h1>Create Question</h1>
      <form action="/quizzes/#{@quiz.id}/questions" method="POST">
      <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
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
    question.save
    redirect_to quiz_questions_path
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
    params.permit(:body, :quiz_id)
  end
end
