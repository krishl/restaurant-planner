class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

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
      restaurant_params[:foods_attributes].each do |food|
        if restaurant_params[:foods_attributes][food][:name] != ""
          food_name = Food.find_by(name: restaurant_params[:foods_attributes][food][:name])
          restaurant_food = RestaurantFood.find_by(restaurant_id: @restaurant.id, food_id: food_name.id)
          restaurant_food.price = restaurant_params[:foods_attributes][food][:restaurant_foods_attributes]["0"][:price]
          restaurant_food.save
        end
      end
      redirect_to user_restaurant_path(current_user, @restaurant), notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  def update
    @restaurant.update(restaurant_params)
    if @restaurant.save
      restaurant_params[:foods_attributes].each do |food|
        if restaurant_params[:foods_attributes][food][:name] != ""
          food_name = Food.find_by(name: restaurant_params[:foods_attributes][food][:name])
          restaurant_food = RestaurantFood.find_by(restaurant_id: @restaurant.id, food_id: food_name.id)
          restaurant_food.price = restaurant_params[:foods_attributes][food][:restaurant_foods_attributes]["0"][:price]
          restaurant_food.save
        end
      end
      redirect_to user_restaurant_path(current_user, @restaurant), notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to user_restaurants_url(current_user), notice: 'Restaurant was successfully deleted.'
  end

  def manhattan
    @manhattan = set_borough('manhattan')
  end

  def brooklyn
    @brooklyn = set_borough('brooklyn')
  end

  def queens
    @queens = set_borough('queens')
  end

  def bronx
    @bronx = set_borough('the bronx')
  end

  def statenisland
    @statenisland = set_borough('staten island')
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :phone, :cuisine, :borough, :user_id, food_ids: [], foods_attributes: [:id, :user_id, :name, restaurant_foods_attributes: [:price]])
    end

    def set_borough(borough)
      current_user.restaurants.borough_restaurants(borough)
    end
end
