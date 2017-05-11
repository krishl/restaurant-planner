class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :cuisine
end
