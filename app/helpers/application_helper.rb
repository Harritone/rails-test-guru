module ApplicationHelper
  def current_year
    DateTime.current.strftime('%Y')
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end

  def flash_messages
    flash.each do |msg_type, message|
      next if msg_type == :form_error
      concat(content_tag(:div, {
        class: "flash-wrapper"}) do
        concat content_tag(:p, message.html_safe, class: "flash #{msg_type}")
      end)
    end
    nil
  end
end
