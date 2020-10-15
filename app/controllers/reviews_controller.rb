class ReviewsController < ApplicationController
  def show
    @review = Review.all
  end

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @user_id = User.where(name: params[:name]).pluck(:id).first
    @shelter = Shelter.find(params[:shelter_id])
    review = Review.new(title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      shelter: @shelter,
      user_id: @user_id)
    # review = Review.new(review_params, user_id: @user_id, shelter: @shelter)
    review.save!

    redirect_to "/shelters/#{@shelter.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
    # params.require(:user).permit(:name, :street_address, :city, :state, :zip)
  end
end
