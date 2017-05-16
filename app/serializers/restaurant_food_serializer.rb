class RestaurantFoodSerializer < ActiveModel::Serializer
  attributes :id, :price, :restaurant_id, :food_id
  belongs_to :restaurant
  belongs_to :food
end
