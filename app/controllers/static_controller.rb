class StaticController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_permission, except: [:home]
  include StaticHelper

  def home
    redirect_to user_path(current_user) if user_signed_in?
  end

  def manhattan
    @manhattan = set_borough('Manhattan')
  end

  def brooklyn
    @brooklyn = set_borough('Brooklyn')
  end

  def queens
    @queens = set_borough('Queens')
  end

  def bronx
    @bronx = set_borough('The Bronx')
  end

  def staten_island
    @statenisland = set_borough('Staten Island')
  end

  def outside_nyc
    @outsidenyc = set_borough('Outside NYC')
  end
end
