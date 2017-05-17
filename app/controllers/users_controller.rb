class UsersController < ApplicationController
  before_action :require_user

  def show
    @restaurant = Restaurant.new
    @food = Food.new
  end

  private

  def require_user
    redirect_to root_path, alert: "Access denied." unless params[:id].to_i == current_user.id
  end
end
