class FeedbackMailer < ApplicationMailer
  def send_feedback(params)
    @name = current_user.username
    @email = current_user.email
    @message = params[:email]

    mail to: Admin.first.email
  end
end
