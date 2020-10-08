require 'rails_helper'

RSpec.describe 'Shelters Delete Behavior' do
  describe 'As a visitor' do
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

    describe 'When I visit a shelter show page' do
      it 'can have a delete link and will redirect to index' do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_1.address)

        expect(page).to have_link('Delete Shelter')
        click_link 'Delete Shelter'

        expect(current_path).to eq('/shelters')
        expect(page).to_not have_content(@shelter_1.name)

        expect(page).to have_content(@shelter_2.name)
      end
    end
  end
end
