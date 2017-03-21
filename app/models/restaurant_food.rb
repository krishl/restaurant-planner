class RestaurantFood < ApplicationRecord
  belongs_to :restaurant, optional: true
  belongs_to :food, optional: true
  after_destroy :check_food, :check_restaurant

  def check_food
    food.destroy_if_orphaned if food
  end

  def check_restaurant
    restaurant.destroy_if_orphaned if restaurant
  end
end
