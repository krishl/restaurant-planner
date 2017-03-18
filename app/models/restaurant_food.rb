class RestaurantFood < ApplicationRecord
  belongs_to :restaurant, optional: true
  belongs_to :food, optional: true
end
