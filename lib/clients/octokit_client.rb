class OctokitClient < Octokit::Client
  def initialize(*args)
    super(*args)
  end

  def response
    self.last_response
  end

  def html_url
    response.data[:html_url] if response
  end
end
