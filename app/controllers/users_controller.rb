class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:user_id])
    @reviews = Review.where(user_id: params[:user_id])
  end

  def new
  end

  def create
    user = User.new(user_params)
    user.save

    redirect_to "/users/#{user.id}"
  end

  private
  def user_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end
