module RestaurantsHelper
  def users_restaurants
    user_restaurant_ids = []
    current_user.restaurants.each do |restaurant|
      user_restaurant_ids << restaurant.id
    end
    user_restaurant_ids
  end
end
