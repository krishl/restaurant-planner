class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :cuisine, :borough
  has_many :foods
  has_many :restaurant_foods
end
