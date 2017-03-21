class Food < ApplicationRecord
  has_many :restaurant_foods
  has_many :restaurants, through: :restaurant_foods
  validates_presence_of :name
end
