require 'rails_helper'

RSpec.describe 'Pet Update' do
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

      image_1 = 'https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg'
      image_2 = 'https://icatcare.org/app/uploads/2018/09/white-cat-1.png'
      image_3 = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg'

      @pet_1 = Pet.create!(image: image_3,
        name: 'Molly',
        description: 'Old English Sheepdog with a bright personality and two different colored eyes',
        approximate_age: 6,
        sex: 'Female',
        shelter_id: "#{@shelter_2.id}",
        adoptable: false)


      @pet_2 = Pet.create!(image: image_1,
        name: 'Misto',
        description: 'Chichuahua, miniture Italian Grey that is a little skiddish, but so sweet',
        approximate_age: 12,
        sex: 'Male',
        shelter_id: "#{@shelter_1.id}",
        adoptable: true)

      @pet_3 = Pet.create!(image: image_2,
        name: 'Monkey',
        description: 'All white cat with green eyes, that is a total cuddlebug',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}",
        adoptable: false)
    end

    it 'can see link to update that specific pet' do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link('Update Pet')
      click_link 'Update'

      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

      expect(find_field(:image).value).to eq 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg'
      expect(find_field(:name).value).to eq 'Molly'
      expect(find_field(:description).value).to eq 'Old English Sheepdog with a bright personality and two different colored eyes'
      expect(find_field(:approximate_age).value).to eq '6'
      expect(find_field(:sex).value).to eq 'Female'

      fill_in :approximate_age, with: '7'
      fill_in :name, with: 'Molli'

      click_button 'Update Pet'

      expect(current_path).to eq("/pets/#{@pet_1.id}")

      expect(page).to have_content('7')
      expect(page).to have_content('Molli')
      expect(page).to_not have_content('12')
      expect(page).to_not have_content('Jimmy')
    end

    it 'can see a link to take you to the Pets Index page' do
      visit "/pets/#{@pet_1.id}/edit"

      expect(page).to have_link('Back to All Shelters')
      click_link 'Back to All Shelters'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content(@shelter_1.name)
    end

    it 'can see a link to take you to the Shelters Index page' do
      visit "/pets/#{@pet_1.id}/edit"

      expect(page).to have_link('Back to All Pets')
      click_link 'Back to All Pets'

      expect(current_path).to eq('/pets')
      expect(page).to have_content(@pet_1.name)
    end
  end
end
