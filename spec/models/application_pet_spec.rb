require 'rails_helper'

RSpec.describe ApplicationPet do
  describe 'validations' do
    it { should allow_value(nil).for(:pet_status) }
  end

  describe 'relationship' do
    it { should belong_to :application }
    it { should belong_to :pet }
  end
end
