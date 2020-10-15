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
    # @user = User.pluck(:name).first
    @user_name = User.where(name: params[:name])
    @shelter = Shelter.find(params[:shelter_id])
    review = Review.new(title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      user: @user_name.first,
      shelter: @shelter)
      # binding.pry
    # review = Review.new(review_params, name: @user_name.first, shelter: @shelter)
    review.save!

    redirect_to "/shelters/#{@shelter.id}"
  end

  private
  def review_params
    # @user_name = User.where(name: params[:name])
    # @shelter = Shelter.find(params[:shelter_id])
    params.permit(:title, :rating, :content, :image)
    # params.require(:user).permit(:name, :street_address, :city, :state, :zip)
  end
end
