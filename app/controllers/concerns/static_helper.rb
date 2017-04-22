module StaticHelper
  def set_borough(borough)
    current_user.restaurants.borough_restaurants(borough)
  end
end
