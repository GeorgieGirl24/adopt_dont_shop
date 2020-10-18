require 'rails_helper'

RSpec.describe Application do
  describe 'validations' do
    it { should validate_presence_of :description}
    it { should validate_presence_of :status }
  end

  describe 'relationship' do
    it { should belong_to :user }
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets)}
  end
end
