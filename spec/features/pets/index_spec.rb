require 'rails_helper'

RSpec.describe 'Pets Index' do
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

      image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg"
      image_2 = "https://icatcare.org/app/uploads/2018/09/white-cat-1.png"
      image_3 = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg"

      @pet_1 = Pet.create!(image: image_3,
        name: 'Mollie',
        approximate_age: 6,
        sex: 'Female',
        shelter_id: "#{@shelter_2.id}")

      @pet_2 = Pet.create!(image: image_1,
        name: 'Misto',
        approximate_age: 12,
        sex: 'Male',
        shelter_id: "#{@shelter_1.id}")

      @pet_3 = Pet.create!(image: image_2,
        name: 'Monkey',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}")
    end

    it 'can visit a pets index page and see each pet in the system including all the information abou the pet' do
      visit '/pets'

      expect(page).to have_css("img[src*='#{@pet_3.image}']")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_3.approximate_age)
      expect(page).to have_content(@pet_3.sex)
      expect(page).to have_content(@shelter_1.name)
    end

    it 'can visit a pet from the Pet Index Page with a link in the Pet name' do
      visit '/pets'

      # expect(page).to have_content(@pet_2.image)
      expect(page).to have_link("#{@pet_2.name}")
      click_link "#{@pet_2.name}"

      expect(current_path).to eq("/pets/#{@pet_2.id}")
      expect(page).to have_content(@pet_2.name)
    end

    it 'can delete a pet from Pet Index page' do
      visit '/pets'

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_link("Delete #{@pet_2.name}")
      click_link "Delete #{@pet_2.name}"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      expect(page).to_not have_content(@pet_2.name)
    end
  end
end
