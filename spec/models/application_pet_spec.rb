require 'rails_helper'

RSpec.describe ApplicationPet do
  describe 'validations' do
    it { should validate_presence_of :pet_status}
  end

  describe 'relationship' do
    it { should belong_to :application }
    it { should belong_to :pet }
  end
end
