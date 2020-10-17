class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def average_review_score(reviews)
    reviews.average(:rating).round(2)
  end
end
