class GistQuestionService
  class Result
    def initialize(hash)
      @hash = hash
    end

    def [](key)
      @hash[key]
    end

    def success?
      !@hash[:html_url].nil?
    end
  end

  def initialize(question, client: nil)
    @question = question
    @quiz = @question.quiz
    @client = client || Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def call
    Result.new(@client.create_gist(gist_params))
  end

  private

  def gist_params
    {
      description: "A question about#{@quiz.title} from QuizGuru",
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
