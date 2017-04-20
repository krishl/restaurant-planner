class StaticController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_before_action :require_permission, only: [:home]

  def home
    redirect_to user_path(current_user) if user_signed_in?
  end

  def under_ten
    @under_ten = current_user.restaurant_foods.under_ten
  end
end
