class RestaurantFoodsController < ApplicationController
  def destroy
    @restaurant_food = RestaurantFood.find(params[:id])
    @restaurant_food.destroy
    redirect_to user_restaurants_url(current_user), notice: 'Successfully deleted.'
  end
end
