class ReviewsController < ApplicationController
  def show
    binding.pry
    @review = Review.find(params[:review_id])
  end

  def index
    binding.pry
    @user = Review.find(params[:user_id])
    @shelter = Shelter.find(params[:shelter_id])
  end
end
