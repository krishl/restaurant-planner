class Food < ApplicationRecord
  has_many :restaurant_foods
  has_many :restaurants, through: :restaurant_foods
  has_many :restaurants
  has_many :users, through: :restaurants
  accepts_nested_attributes_for :restaurant_foods, allow_destroy: true
end
