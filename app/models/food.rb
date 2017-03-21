class Food < ApplicationRecord
  has_many :restaurant_foods, dependent: :destroy
  has_many :restaurants, through: :restaurant_foods
  accepts_nested_attributes_for :restaurant_foods, :restaurants
  validates_presence_of :name

  def destroy_if_orphaned
    if restaurants.count == 0
      self.destroy
    end
  end
end
