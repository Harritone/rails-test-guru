class ApplicationController < ActionController::Base
  helper_method :current_user,
                :logged_in?

  private

  def authenticate_user!
    return if current_user

    cookies[:path] = request.url

    redirect_to sign_in_path, alert: 'Are you a Guru yet? Verify your Email and Password please.'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
