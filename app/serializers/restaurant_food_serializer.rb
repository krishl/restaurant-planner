class RestaurantFoodSerializer < ActiveModel::Serializer
  attributes :id, :price
  belongs_to :restaurant
  belongs_to :food
end
