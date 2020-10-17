class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def highest_rated_review
    @user = User.all.first
    @user.reviews.order(rating: :desc).pluck(:rating).first
  end

  def lowest_rated_review
    @user = User.all.first
    @user.reviews.order(:rating).pluck(:rating).first
  end
end
