class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome, #{current_user.username}!"
    admin_quizzes_path if current_user.is_a?(Admin)
  end
end
