class UsersController < ApplicationController
  skip_before_action :require_permission
  before_action :require_user

  def show
  end

  private

  def require_user
    redirect_to root_path, alert: "Access denied." unless params[:id].to_i == current_user.id
  end
end
