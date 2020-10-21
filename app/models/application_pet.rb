class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  validates_presence_of :pet_status

  # def find_pet_id
  #   self.pet_id
  #
  # end
end
