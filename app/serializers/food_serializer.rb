class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :restaurants
  has_many :restaurant_foods
end
