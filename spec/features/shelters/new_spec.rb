require 'rails_helper'

RSpec.describe 'Shelter Index' do
  describe 'As a visitor' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349')

      image_2 = "https://icatcare.org/app/uploads/2018/09/white-cat-1.png"

      @pet_3 = Pet.create!(image: image_2,
        name: 'Monkey',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}")
    end
    describe 'you can see a link to create a new link' do
      it 'can be clicked and that will lead to a form to be filled out' do
        visit '/shelters'

        expect(page).to have_link('New Shelter')
        click_link 'New Shelter'

        expect(current_path).to eq('/shelters/new')
        expect(page).to have_content("Adopt Don't Shop")

        fill_in :name, with: 'Max Fund - Littleton'
        fill_in :address, with: '1234 Broadway St'
        fill_in :city, with: 'Littleton'
        fill_in :state, with: 'CO'
        fill_in :zip, with: '82349'

        expect(page).to have_button('Create Shelter')
        click_button 'Create Shelter'

        expect(current_path).to eq('/shelters')
        expect(page).to have_content('Max Fund - Littleton')
      end

      it 'can see a link to Pets Index' do
        visit '/shelters/new'

        expect(page).to have_content("Adopt Don't Shop")

        expect(page).to have_link('Back to All Pets')
        click_link 'Back to All Pets'

        expect(current_path).to eq('/pets')
      end

      it 'can see a link to Shelters Index' do
        visit '/shelters/new'

        expect(page).to have_content("Adopt Don't Shop")

        expect(page).to have_link('Back to All Shelters')
        click_link 'Back to All Shelters'

        expect(current_path).to eq('/shelters')
      end
    end
  end
end
