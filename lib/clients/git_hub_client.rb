class GitHubClient
  ROOT_ENDPOINT = 'https://api.github.com'.freeze
  ACCESS_TOKEN = Rails.application.credentials.dig(:github, :token)

  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    @response = @http_client.post('gists') do |req|
      req.headers['Authorization'] = "token #{ACCESS_TOKEN}"
      req.headers['Content-Type'] = 'application/json'
      req.body = params.to_json
    end
  end

  def html_url
    JSON.parse(@response.body)['html_url'] if @response
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
