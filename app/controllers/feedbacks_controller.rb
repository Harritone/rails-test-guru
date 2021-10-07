class FeedbacksController < ApplicationController
  def send_feedback
    FeedbackMailer.send_feedback(feedback_params) unless feedback_params[:message].empty?
    redirect_to root_path, notice: 'feedback sent'
  end

  def feedback_params
    params.permit(:message)
  end
end
