class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_many :restaurants
  has_many :foods
end
