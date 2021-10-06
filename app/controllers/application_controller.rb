class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def after_sign_in_path_for(resource)
    flash[:notice] = t('.welcome', username: resource.username)
    resource.admin? ? admin_quizzes_path : root_path
  end

  def default_url_options
    { lang: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name) }
  end
end
