class Food < ApplicationRecord
  has_many :restaurant_foods, dependent: :destroy
  has_many :restaurants, through: :restaurant_foods
  accepts_nested_attributes_for :restaurants, :restaurant_foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}}, allow_destroy: true
  validates :name, uniqueness: true, presence: true

  def restaurants_attributes=(restaurants_attributes)
    restaurants_attributes.values.each do |restaurants_attribute|
      if restaurants_attribute[:name] != ""
        restaurant = Restaurant.find_or_create_by(name: restaurants_attribute[:name])
        self.restaurants << restaurant
      end
    end
  end

  def destroy_if_orphaned
    if restaurants.count == 0
      self.destroy
    end
  end
end
