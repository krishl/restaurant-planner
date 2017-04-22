class Food < ApplicationRecord
  has_many :restaurant_foods, dependent: :destroy
  has_many :restaurants,   -> { distinct }, through: :restaurant_foods
  accepts_nested_attributes_for :restaurants, :restaurant_foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}}, allow_destroy: true
  validates :name, :user_id, presence: true
  belongs_to :user

  def restaurants_attributes=(restaurants_attributes)
    restaurants_attributes.values.each do |restaurants_attribute|
      if restaurants_attribute[:name] != ""
        restaurant = Restaurant.find_or_create_by(name: restaurants_attribute[:name], user_id: restaurants_attribute[:user_id])
        self.restaurants << restaurant
      end
    end
  end

  def destroy_if_orphaned
    if self.restaurants.count == 0
      self.destroy
    end
  end

  def self.save_food(food, food_params)
    food_params[:restaurants_attributes].each do |restaurant|
      if food_params[:restaurants_attributes][restaurant][:name] != ""
        restaurant_name = Restaurant.find_by(name: food_params[:restaurants_attributes][restaurant][:name])
        restaurant_food = RestaurantFood.find_by(restaurant_id: restaurant_name.id, food_id: food.id)
        restaurant_food.price = food_params[:restaurants_attributes][restaurant][:restaurant_foods_attributes]["0"][:price]
        restaurant_food.save
      end
    end
  end

  def self.find_under_ten(user_id)
    self.where("user_id = ?", user_id).joins(:restaurant_foods).where("price <= ?", 10)
  end
end
