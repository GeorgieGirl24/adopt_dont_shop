class ReviewsController < ApplicationController
  def show
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
      shelter_id: @shelter.id,
      user_id: @user_id)
    if @user_id.nil?
      flash[:alert] = "That name doesn't exisit in our database. You must be a valid user."
      redirect_to "/shelters/#{@shelter.id}/reviews/new"
    elsif review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:alert] = 'Required information missing. Request not submitted'
      redirect_to "/shelters/#{@shelter.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @shelter = Shelter.find(@review.shelter_id)
    @user = User.find(@review.user_id)
  end

  def update
    @user = User.find_by(name: params[:name])
    @review = Review.find(params[:review_id])
    @shelter = Shelter.find(@review.shelter_id)
    if @user.nil?
      flash[:alert] = "That name doesn't exisit in our database. You must be a valid user."
      redirect_to "/reviews/#{@review.id}/edit"
    elsif review = @review.update(title: params[:title],
      rating: params[:rating],
      content: params[:content],
      image: params[:image],
      shelter: @shelter,
      user: @user)
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash.now[:alert] = 'Empty Field. Please try again.'
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy
    redirect_to "/shelters/#{@review.shelter.id}"
  end
end
