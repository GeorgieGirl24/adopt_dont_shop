class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:review_id])
  end

  def index
    @review = Review.all
  end
end
