require 'rails_helper'

RSpec.describe 'Shelters New' do
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

      image_1 = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg"

      @pet_1 = Pet.create!(image: image_1,
        name: 'Mollie',
        description: 'Old English Sheepdog with a bright personality and two different colored eyes',
        approximate_age: 6,
        sex: 'Female',
        shelter_id: "#{@shelter_2.id}",
        adoptable: false)
    end

    describe 'When I visit a shelter show page then click the link update the shelter "Update Shelter"' do
      it 'can edit the shelter form' do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_link('Update Shelter')
        click_link 'Update Shelter'

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

        expect(find_field(:name).value).to eq 'Max Fund - Littleton'
        expect(find_field(:address).value).to eq '1234 Broadway St'
        expect(find_field(:city).value).to eq 'Littleton'
        expect(find_field(:state).value).to eq 'CO'
        expect(find_field(:zip).value).to eq '82349'

        fill_in :name, with: 'Max Fund - Aurora'

        click_button('Edit Shelter')
        expect(current_path).to eq("/shelters")
        expect(page).to have_content('Max Fund - Aurora')
      end
    end

    it 'can have a link to see the Pet Index' do
      visit "/shelters/#{@shelter_2.id}/edit"

      expect(page).to have_link('Back to All Pets')
      click_link 'Back to All Pets'

      expect(current_path).to eq('/pets')
      expect(page).to have_content(@pet_1.name)
    end

    it 'can have a link to see the Shelter Index' do
      visit "/shelters/#{@shelter_1.id}/edit"

      expect(page).to have_link('Back to All Shelters')
      click_link 'Back to All Shelters'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content(@shelter_1.name)
    end

  end
end
