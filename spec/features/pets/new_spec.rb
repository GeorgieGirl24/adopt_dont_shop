require 'rails_helper'

RSpec.describe 'New Pet' do
  describe 'As a visitor' do
    # describe 'when I visit a Shelter Pets Index page' do
    before do
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

      image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg"
      image_2 = "https://icatcare.org/app/uploads/2018/09/white-cat-1.png"
      image_3 = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg"

      @pet_1 = Pet.create!(image: image_3,
        name: 'Mollie',
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

    it 'can see a link to add a new adoptable pet for that shelter' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Add a Pet to Shelter')
      click_link 'Add a Pet to Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

      new_pet_image = 'https://www.rover.com/blog/wp-content/uploads/2016/02/6131305908_d882b5628e_o.jpg'

      fill_in :image, with: new_pet_image
      fill_in :name, with: 'Cooper'
      fill_in :description, with: 'A young golden lab that loves the water and kids'
      fill_in :approximate_age, with: 1
      fill_in :sex, with: 'Male'

      expect(page).to have_button('Add Pet to Shelter')
      click_button 'Add Pet to Shelter'


      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      expect(page).to have_css("img[src*='#{new_pet_image}']")
      expect(page).to have_content('Cooper')
      expect(page).to have_content('A young golden lab that loves the water and kids')
      expect(page).to have_content('Male')
      # expect(page).to have_content('Adoptable')
    end
  end
end
