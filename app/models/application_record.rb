class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def average_review_score
    self.reviews.average(:rating)
  end
end
