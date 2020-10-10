require 'rails_helper'

RSpec.describe 'Shelters Index' do
  describe 'User' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349')
      @shelter_2 = Shelter.create!(name: 'Humane Society - Thorton',
        address: '12489 120 St',
        city: 'Thorton',
        state: 'CO',
        zip: '80829')
    end

    it "can see the name of each shelter in the system" do
      visit "/shelters"
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end
  end
end
