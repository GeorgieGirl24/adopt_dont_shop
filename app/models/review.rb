class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content
  validates_presence_of :image, :allow_blank => true
end
