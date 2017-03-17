class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :restaurant_food
  has_many :foods, through: :restaurant_food
end
