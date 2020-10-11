require 'rails_helper'

RSpec.describe 'Shelter Show' do
  describe 'As a visitor' do
    describe 'when I visit the shelter show page' do
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

      it 'can see the shelters information' do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_1.address)
        expect(page).to have_content(@shelter_1.city)
        expect(page).to have_content(@shelter_1.state)
        expect(page).to have_content(@shelter_1.zip)
        expect(page).to_not have_content(@shelter_2.name)
      end

      it 'can have a link to take you back to Shelters Index page' do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_link('Back to All Shelters')
        click_link 'Back to All Shelters'

        expect(current_path).to eq('/shelters')
        expect(page).to have_content(@shelter_1.name)
      end

      it 'can have a link to take you back to Pets Index page' do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_link('Back to All Pets')
        click_link 'Back to All Pets'

        expect(current_path).to eq('/pets')
      end
    end
  end
end
