class Food < ApplicationRecord
  has_many :restaurant_foods
  has_many :restaurants, through: :restaurant_food
  has_many :restaurants
  has_many :users, through: :restaurants
end
