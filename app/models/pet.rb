class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets

  validates_presence_of :shelter_id

  def shelter_name
    self.shelter.name
  end

  def find_shelter_id
    self.shelter.id
  end
end
