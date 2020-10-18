class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def total_pets
    self.pets.count
  end
end
