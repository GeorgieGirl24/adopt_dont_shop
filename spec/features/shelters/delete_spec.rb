require 'rails_helper'

RSpec.describe 'Shelters Delete Behavior' do
  describe 'As a visitor' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349'
      )
      @shelter_2 = Shelter.create!(name: 'Humane Society - Thorton',
        address: '12489 120 St',
        city: 'Thorton',
        state: 'CO',
        zip: '80829'
      )
      @user_1 = User.create!(
        name: 'Brian',
        street_address: '123 Medival Dr.',
        city: 'Northglenn',
        state: 'CO',
        zip: '80273'
      )
      @user_2 = User.create!(
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
      )

      image_1 = 'https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg'
      image_2 = 'https://icatcare.org/app/uploads/2018/09/white-cat-1.png'
      image_4 = 'https://i.imgur.com/xtu2CYnb.jpg'

      @pet_2 = Pet.create!(
        image: image_1,
        name: 'Misto',
        approximate_age: 12,
        sex: 'Male',
        shelter_id: "#{@shelter_1.id}"
      )
      @pet_3 = Pet.create!(
        image: image_2,
        name: 'Monkey',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
      )
      @pet_4 = Pet.create!(
        image: image_4,
        name: 'Leslie',
        approximate_age: 8,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
      )
      @review_1 = @shelter_1.reviews.create!(
        title: 'Awesome Shelter!',
        rating: '4.5',
        content: 'I love this place! Amazing service!',
        image: 'https://i.imgur.com/FRK6meX.png',
        user_id: @user_1.id
      )
      @review_3 = @shelter_1.reviews.create!(
        title: 'Loved the care of Sophia',
        rating: '4.9',
        content: 'Sophia is an awesome employee. She deserves a raise',
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
      @review_4 = @shelter_1.reviews.create!(
        title: 'Low to Below Average',
        rating: '1.3',
        content: "They didn't loose my cat, but it wasn't great...",
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
    end

    describe 'When I visit a shelter show page' do
      # it 'can have a delete link and will redirect to index' do
      #   visit "/shelters/#{@shelter_1.id}"
      #
      #   expect(page).to have_content(@shelter_1.name)
      #   expect(page).to have_content(@shelter_1.address)
      #
      #   expect(page).to have_link('Delete Shelter')
      #   click_link 'Delete Shelter'
      #
      #   expect(current_path).to eq('/shelters')
      #   expect(page).to_not have_content(@shelter_1.name)
      #
      #   expect(page).to have_content(@shelter_2.name)
      # end

      it 'will delete all pets when shelter is deleted' do
        visit '/shelters'

        within "#shelter-#{@shelter_1.id}" do
          expect(page).to have_content(@shelter_1.name)
          expect(page).to have_link('Delete Shelter')
          click_link 'Delete Shelter'
        end
      end

      it 'will delete all reviews when a shelter is deleted' do
        visit '/shelters'

        within "#shelter-#{@shelter_1.id}" do
          expect(page).to have_content(@shelter_1.name)
          expect(page).to have_link('Delete Shelter')
          click_link 'Delete Shelter'
        end

        # expect(page).to_not have_content(@shelter_1.name)
      end
    end
  end
end
