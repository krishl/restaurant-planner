class Food < ApplicationRecord
  has_many :restaurant_food
  has_many :restaurants, through: :restaurant_food
end
