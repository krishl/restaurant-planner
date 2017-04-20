class RestaurantFood < ApplicationRecord
  belongs_to :restaurant, optional: true
  belongs_to :food, optional: true
  after_destroy :check_food, :check_restaurant
  validates :price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def check_food
    food.destroy_if_orphaned if food
  end

  def check_restaurant
    restaurant.destroy_if_orphaned if restaurant
  end

  def self.under_ten
    self.all.select do |restaurant_food|
      restaurant_food if restaurant_food.price <= 10
    end
  end
end
