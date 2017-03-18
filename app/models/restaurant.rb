class Restaurant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :restaurant_foods
  has_many :foods, through: :restaurant_foods
  accepts_nested_attributes_for :foods, :reject_if => proc {|attributes|
    attributes.all? {|k,v| v.blank?}
  }
end
