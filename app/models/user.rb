class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :applications, dependent: :destroy


  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def highest_rated_review
    highest = self.reviews.order(rating: :desc).first
    if self.reviews.empty?
      highest_review = {title: nil,
        rating: nil,
        content: nil,
        image: nil
      }
    else
      highest_review = {
        title: highest.title,
        rating: highest.rating,
        content: highest.content,
        image: highest.image
      }
    end
  end

  def lowest_rated_review
    lowest = self.reviews.order(:rating).first
    if self.reviews.empty?
      lowest_review = {
        title: nil,
        rating: nil,
        content: nil,
        image: nil
      }
    else
      lowest_review = {
        title: lowest.title,
        rating: lowest.rating,
        content: lowest.content,
        image: lowest.image
      }
    end
  end

  def address
    "#{self.street_address} #{self.city} #{self.state} #{self.zip}"
  end
end
