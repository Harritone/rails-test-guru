module ApplicationHelper
  def current_year
    DateTime.current.strftime('%Y')
  end

  def github_url(author, repo)
    link_to repo, "https://github.com/#{author}/#{repo}", target: '_blank'
  end

 def bootstrap_class_for flash_type
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(_opts = {})
    # return if flash[0][0] == :form_error
    flash.each do |msg_type, message|
      next if msg_type == :form_error
      concat(content_tag(:div, message.html_safe, {
        class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show"}) do
        concat content_tag(:button, '', class: "btn-close", data: {
          "bs-dismiss": 'alert'
          })
        concat message.html_safe
      end)
    end
    nil
  end
end
