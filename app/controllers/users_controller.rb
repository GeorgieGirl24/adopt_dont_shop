class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def new
    binding.pry
    @user = User.find(params[:user_id])
  end

  def create
    user = User.new(user_params)
    user.save

    redirect "/users/#{user.id}"
  end

  private
  def user_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end
