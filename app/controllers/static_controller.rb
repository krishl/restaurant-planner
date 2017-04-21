class StaticController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_permission, raise: false

  def home
    redirect_to user_path(current_user) if user_signed_in?
  end
end
