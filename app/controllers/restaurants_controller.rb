class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
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
      redirect_to user_restaurant_path(current_user, @restaurant), notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  def update
    @restaurant.update(restaurant_params)
    if @restaurant.save
      redirect_to user_restaurant_path(@restaurant), notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
      redirect_to user_restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :phone, :cuisine, foods_attributes: [:id, :name, :price])
    end
end
