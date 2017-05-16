class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :cuisine, :borough, :user_id
  has_many :foods
  has_many :restaurant_foods
  belongs_to :user
end
