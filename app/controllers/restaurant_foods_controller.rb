class RestaurantFoodsController < ApplicationController
  skip_before_action :require_permission, raise: false

  def destroy
    @restaurant_food = RestaurantFood.find(params[:id])
    @restaurant_food.destroy
    redirect_to user_restaurants_url(current_user), notice: 'Successfully deleted.'
  end

  def under_ten
    @under_ten = RestaurantFood.under_ten
  end
end
