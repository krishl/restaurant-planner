class StaticController < ApplicationController
  def home
    redirect_to user_path(current_user) if user_signed_in?
  end
end
