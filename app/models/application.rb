class Application < ApplicationRecord
  belongs_to :user
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  validates_presence_of :description
  validates_presence_of :status

  def add_pet(pet_id)
    self.pets << Pet.find(pet_id)
  end
end
