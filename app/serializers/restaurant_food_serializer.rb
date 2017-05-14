class RestaurantFoodSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :restaurant
  belongs_to :food
end
