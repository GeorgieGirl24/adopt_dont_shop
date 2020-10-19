class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  validates_presence_of :shelter_id

  def self.search(search)
    pet = Pet.find_by(name: search)
    if pet
      self.where(name: pet.name)
    else
      pet = []
    end
  end
end
