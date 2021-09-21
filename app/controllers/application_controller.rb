class ApplicationController < ActionController::Base
  helper_method :current_user

  def authenticate_user!
    redirect_to sign_in_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end
end
