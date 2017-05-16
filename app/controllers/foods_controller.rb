class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  before_action :require_permission
  include FoodsHelper

  def index
    @foods = current_user.foods
    respond_to do |format|
      format.html
      format.json { render json: @foods }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @food }
    end
  end

  def new
    @food = Food.new
  end

  def edit
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      Food.save_food(@food, food_params)
      redirect_to user_food_path(current_user, @food), notice: 'Menu item was successfully created.'
    else
      render :new
    end
  end

  def update
    @food.update(food_params)
    if @food.save
      Food.save_food(@food, food_params)
      redirect_to user_food_path(current_user, @food), notice: 'Menu item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food.destroy
    redirect_to user_path(current_user), notice: 'Menu item was successfully deleted.'
  end

  private
    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:name, :user_id, restaurant_ids: [], restaurants_attributes: [:id, :name, :address, :phone, :cuisine, :borough, :user_id, restaurant_foods_attributes: [:price]])
    end
end
