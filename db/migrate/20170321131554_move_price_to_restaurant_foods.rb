class MovePriceToRestaurantFoods < ActiveRecord::Migration[5.0]
  def change
    remove_column :foods, :price, :decimal
    add_column :restaurant_foods, :price, :decimal
  end
end
