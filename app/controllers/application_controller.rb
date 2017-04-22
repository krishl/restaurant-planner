class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def require_permission
    redirect_to root_path, alert: "Access denied." unless params[:user_id].to_i == current_user.id
  end
end
