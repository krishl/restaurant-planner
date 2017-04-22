class Restaurant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :restaurant_foods, dependent: :destroy
  has_many :foods,   -> { distinct }, through: :restaurant_foods
  accepts_nested_attributes_for :foods, :restaurant_foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}}, allow_destroy: true
  validates :name, presence: true
  validates :user_id, presence: true

  def foods_attributes=(foods_attributes)
    foods_attributes.values.each do |foods_attribute|
      if foods_attribute[:name] != ""
        food = Food.find_or_create_by(name: foods_attribute[:name], user_id: foods_attribute[:user_id])
        self.foods << food
      end
    end
  end

  def destroy_if_orphaned
    if self.foods.count == 0
      self.destroy
    end
  end

  def self.borough_restaurants(borough)
    where(borough: borough)
  end

  def self.save_restaurant(restaurant, restaurant_params)
    restaurant_params[:foods_attributes].each do |food|
      if restaurant_params[:foods_attributes][food][:name] != ""
        food_name = Food.find_by(name: restaurant_params[:foods_attributes][food][:name])
        restaurant_food = RestaurantFood.find_by(restaurant_id: restaurant.id, food_id: food_name.id)
        restaurant_food.price = restaurant_params[:foods_attributes][food][:restaurant_foods_attributes]["0"][:price]
        restaurant_food.save
      end
    end
  end
end
