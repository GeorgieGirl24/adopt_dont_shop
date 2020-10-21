class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  validates_presence_of :pet_status, :allow_nil => true

  def pet_name
    self.pet.name
  end

  def pet_adoptable?
    self.pet.adoptable
  end
end
