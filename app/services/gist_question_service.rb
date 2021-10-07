class GistQuestionService
  FIRST_SUCCESS_STATUS_CODE = 200.freeze
  LAST_SUCCESS_STATUS_CODE = 226.freeze

  def initialize(question, client: nil)
    @question = question
    @quiz = @question.quiz
    @client = client || OctokitClient.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def call
    @client.create_gist(gist_params)
    self
  end

  def html_url
    @client.html_url
  end

  def success?
    @client.response.status.between?(FIRST_SUCCESS_STATUS_CODE,
                                         LAST_SUCCESS_STATUS_CODE)
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_question_service.description', title: @quiz.title),
      files: {
        'quiz-guru-question.txt': {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
