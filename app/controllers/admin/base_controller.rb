class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.is_a?(Admin)
  end
end