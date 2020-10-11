require 'rails_helper'

RSpec.describe 'Pet Delete' do
  describe 'As a visitor' do
    describe 'When I visit a pet show page' do
      before :each do
        @shelter_1 = Shelter.create!(name: 'Humane Society - Thorton',
          address: '12489 120 St',
          city: 'Thorton',
          state: 'CO',
          zip: '80829')

        @shelter_2 = Shelter.create!(name: 'Humane Society - Thorton',
          address: '12489 120 St',
          city: 'Thorton',
          state: 'CO',
          zip: '80829')

        image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg"
        image_2 = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg"

        @pet_1 = Pet.create!(image: image_2,
          name: 'Molli',
          description: 'Old English Sheepdog with a bright personality and two different colored eyes',
          approximate_age: 6,
          sex: 'Female',
          shelter_id: "#{@shelter_1.id}",
          adoptable: false)

        @pet_2 = Pet.create!(image: image_1,
          name: 'Misto',
          description: 'Chichuahua, miniture Italian Grey that is a little skiddish, but so sweet',
          approximate_age: 12,
          sex: 'Male',
          shelter_id: "#{@shelter_1.id}",
          adoptable: true)
      end

      it 'can have a link to delete the pet and when you click it, it sends you back to the pet index page' do
        visit "/pets/#{@pet_1.id}"

        expect(page).to have_link('Delete Pet')
        click_link 'Delete Pet'

        expect(current_path).to eq("/shelters/#{@pet_1.shelter_id}/pets")

        expect(page).to_not have_content('Molli')
        expect(page).to have_content(@pet_2.name)
      end
    end
  end
end
