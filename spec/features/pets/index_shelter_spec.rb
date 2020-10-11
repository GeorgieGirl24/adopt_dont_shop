require 'rails_helper'

RSpec.describe 'Pets Index in a Shelter' do
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

    it 'can see each Pet from a unique Shelter' do
      visit "/shelters/#{@shelter_1.id}/pets"

      expect(page).to have_content(@shelter_1.name)

      expect(page).to have_css("img[src*='#{@pet_3.image}']")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_3.approximate_age)
      expect(page).to have_content(@pet_3.sex)

      expect(page).to have_css("img[src*='#{@pet_2.image}']")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.approximate_age)
      expect(page).to have_content(@pet_2.sex)
    end

    it 'can delete a Pet from the Shelter' do
      visit "/shelters/#{@shelter_2.id}/pets"

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_link("Delete #{@pet_1.name}")
      click_link "Delete #{@pet_1.name}"

      expect(current_path).to eq("/shelters/#{@shelter_2.id}/pets")
      expect(page).to_not have_content(@pet_1.name)
    end

    # it 'can see an update link' do
    #   visit "/shelters/#{@shelter_1.id}/pets"
    #
    #   expect(page).to have_content(@pet_3.name)
    #   expect(page).to have_link('Update Pet')
    #   # click_link 'Update Pet'
    #
    #   expect(current_path).to eq("/pets/#{@pet_3.id}/edit")
    #   expect(page).to have_content('Edit the Pet')
    # end

    it 'can see a link go to Pets Index' do
      visit "/shelters/#{@shelter_1.id}/pets"

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)

      expect(page).to have_link('Back to All Pets')
      click_link 'Back to All Pets'

      expect(current_path).to eq('/pets')
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_1.name)
    end

    it 'can see a link go to Shelters Index' do
      visit "/shelters/#{@shelter_2.id}/pets"

      expect(page).to have_content(@pet_1.name)

      expect(page).to have_link('Back to All Shelters')
      click_link 'Back to All Shelters'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end
  end
end
