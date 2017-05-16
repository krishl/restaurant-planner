module FoodsHelper
  def users_foods
    user_food_ids = []
    current_user.foods.each do |food|
      user_food_ids << food.id
    end
    user_food_ids
  end
end
