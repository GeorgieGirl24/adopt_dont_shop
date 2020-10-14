class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:review_id])
  end

  def index

    @review = Review.all
    # @shelter = Shelter.find(params[:shelter_id])
  end
end
