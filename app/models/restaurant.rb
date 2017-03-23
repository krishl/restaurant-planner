class Restaurant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :restaurant_foods, dependent: :destroy
  has_many :foods, through: :restaurant_foods
  accepts_nested_attributes_for :foods, :restaurant_foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}}, allow_destroy: true
  validates :name, presence: true
  validates :user_id, presence: true

  def foods_attributes=(foods_attributes)
    foods_attributes.values.each do |foods_attribute|
      if foods_attribute[:name] != ""
        food = Food.find_or_create_by(name: foods_attribute[:name])
        self.foods << food
      end
    end
  end

  def destroy_if_orphaned
    if foods.count == 0
      self.destroy
    end
  end
end
