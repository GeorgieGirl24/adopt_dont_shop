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
# user_id: @user_id
# move to Model
    # review = Review.new(review_params)
    # review.user_id = @user_id
    # review.shelter_id = @shelter.id
    # new_review = Review.make_review
    new_review.save!
      redirect_to "/shelters/#{@shelter.id}"
    # else
    #   flash[:error] = 'You need to fill this form out completely! Try again'
    #   # render/
    #   redirect_to "/shelters/#{@shelter.id}/new"
    # end
  end

  def edit
    @review = Review.find(params[:review_id])
    @shelter = Shelter.find(@review.shelter_id)
    @user = User.find(@review.user_id)
  end

  def update
    review = Review.find(params[:review_id])
    @review = Review.update(review_params)
    @shelter = Shelter.find(review.shelter_id)
    redirect_to "/shelters/#{@shelter.id}"
  end
  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
