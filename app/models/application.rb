class Application < ApplicationRecord
  belongs_to :user
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of :description
  validates_presence_of :status
end