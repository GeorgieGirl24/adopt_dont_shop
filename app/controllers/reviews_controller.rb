class ReviewsController < ApplicationController
  def index
    # binding.pry
    @shelter = Shelter.find(params[:shelter_id])

  end
end
