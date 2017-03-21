class Restaurant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :restaurant_foods
  has_many :foods, through: :restaurant_foods, dependent: :destroy
  validates_presence_of :name
  accepts_nested_attributes_for :foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}}, allow_destroy: true

  def foods_attributes=(foods_attributes)
    foods_attributes.values.each do |foods_attribute|
      if foods_attribute[:name] != ""
        food = Food.find_or_create_by(name: foods_attribute[:name], price: foods_attribute[:price])
        self.foods << food
      end
    end
  end
end
