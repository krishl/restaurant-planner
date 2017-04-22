class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :require_permission

  def index
    @restaurants = current_user.restaurants
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      Restaurant.save_restaurant(@restaurant, restaurant_params)
      redirect_to user_restaurant_path(current_user, @restaurant), notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  def update
    @restaurant.update(restaurant_params)
    if @restaurant.save
      Restaurant.save_restaurant(@restaurant, restaurant_params)
      redirect_to user_restaurant_path(current_user, @restaurant), notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to user_restaurants_url(current_user), notice: 'Restaurant was successfully deleted.'
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :phone, :cuisine, :borough, :user_id, food_ids: [], foods_attributes: [:id, :user_id, :name, restaurant_foods_attributes: [:price]])
    end
end
