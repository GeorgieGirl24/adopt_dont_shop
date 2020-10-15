class ReviewsController < ApplicationController
  def show
    @review = Review.all
  end

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    # binding.pry
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    # binding.pry
    # @user = User.find(params[:user_id])
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    review.save

    redirect_to "/shelters/#{@shelter_id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image, :name, :shelter_id)
  end
end
