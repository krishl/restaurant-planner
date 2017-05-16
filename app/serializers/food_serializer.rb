class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id
  has_many :restaurants
  has_many :restaurant_foods
  belongs_to :user
end
