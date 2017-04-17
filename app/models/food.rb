class Food < ApplicationRecord
  has_many :restaurant_foods, dependent: :destroy
  has_many :restaurants,   -> { distinct }, through: :restaurant_foods
  accepts_nested_attributes_for :restaurants, :restaurant_foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}}, allow_destroy: true
  validates :name, presence: true
  belongs_to :user, optional: true

  def restaurants_attributes=(restaurants_attributes)
    restaurants_attributes.values.each do |restaurants_attribute|
      if restaurants_attribute[:name] != ""
        restaurant = Restaurant.find_or_create_by(name: restaurants_attribute[:name], user_id: restaurants_attribute[:user_id])
        self.restaurants << restaurant
      end
    end
  end

  def destroy_if_orphaned
    if self.restaurants.count == 0
      self.destroy
    end
  end
end
