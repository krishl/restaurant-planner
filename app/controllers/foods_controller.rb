class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  def index
    @foods = Food.all
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
          restaurant_food = RestaurantFood.find_by(restaurant_id: restaurant.id, food_id: @food_name.id)
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
      redirect_to user_food_path(@food), notice: 'Menu item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    redirect_to user_restaurants_url, notice: 'Menu item was successfully deleted.'
  end

  private
    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:name, :price, restaurant_params: [:name, :address, :phone, :cuisine, :user_id, food_ids: [], restaurant_foods_attributes: [:price]])
    end
end
