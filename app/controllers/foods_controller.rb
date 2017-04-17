class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_permission

  def index
    @foods = current_user.foods.uniq
  end

  def show
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      food_params[:restaurants_attributes].each do |restaurant|
        if food_params[:restaurants_attributes][restaurant][:name] != ""
          restaurant_name = Restaurant.find_by(name: food_params[:restaurants_attributes][restaurant][:name])
          restaurant_food = RestaurantFood.find_by(restaurant_id: restaurant_name.id, food_id: @food.id)
          restaurant_food.price = food_params[:restaurants_attributes][restaurant][:restaurant_foods_attributes]["0"][:price]
          restaurant_food.save
        end
      end
      redirect_to user_food_path(current_user, @food), notice: 'Menu item was successfully created.'
    else
      render :new
    end
  end

  def update
    @food.update(food_params)
    if @food.save
      food_params[:restaurants_attributes].each do |restaurant|
        if food_params[:restaurants_attributes][restaurant][:name] != ""
          restaurant_name = Restaurant.find_by(name: food_params[:restaurants_attributes][restaurant][:name])
          restaurant_food = RestaurantFood.find_by(restaurant_id: restaurant_name.id, food_id: @food.id)
          restaurant_food.price = food_params[:restaurants_attributes][restaurant][:restaurant_foods_attributes]["0"][:price]
          restaurant_food.save
        end
      end
      redirect_to user_food_path(current_user, @food), notice: 'Menu item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    redirect_to user_foods_path(current_user), notice: 'Menu item was successfully deleted.'
  end

  private
    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:name, :user_id, restaurant_ids: [], restaurants_attributes: [:id, :name, :address, :phone, :cuisine, :user_id, restaurant_foods_attributes: [:price]])
    end

    def require_permission
      redirect_to root_path, alert: "Access denied." unless params[:user_id].to_i == current_user.id
    end
end
