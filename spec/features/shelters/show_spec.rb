require 'rails_helper'

RSpec.describe 'Shelter Show' do
  describe 'As a visitor' do
    describe 'when I visit the shelter show page' do
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
        image_3 = 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg'
        image_4 = 'https://i.imgur.com/xtu2CYnb.jpg'
        image_5 = 'https://i.imgur.com/rznWo0nb.jpg'

        @pet_1 = Pet.create!(
          image: image_3,
          name: 'Mollie',
          approximate_age: 6,
          sex: 'Female',
          shelter_id: "#{@shelter_2.id}"
        )
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
        @pet_5 = Pet.create!(
          image: image_5,
          name: 'Mr. T',
          approximate_age: 3,
          sex: 'Female',
          shelter_id: "#{@shelter_2.id}"
        )
        @review_1 = @shelter_1.reviews.create!(
          title: 'Awesome Shelter!',
          rating: '4.5',
          content: 'I love this place! Amazing service!',
          image: 'https://i.imgur.com/FRK6meX.png',
          user_id: @user_1.id
        )
        @review_2 = @shelter_2.reviews.create!(
          title: 'This place is aight',
          rating: '3.5',
          content: 'I mean...its aight, whatever.',
          image: '',
          user_id: @user_1.id
        )
        @review_3 = @shelter_2.reviews.create!(
          title: 'Loved the care of Sophia',
          rating: '4.9',
          content: 'Sophia is an awesome employee. She deserves a raise',
          image: 'https://i.imgur.com/ETO90Ubb.jpg',
          user_id: @user_1.id
        )
        @review_4 = @shelter_1.reviews.create!(
          title: 'Loved the care of Sophia',
          rating: '4.9',
          content: 'Sophia is an awesome employee. She deserves a raise',
          image: 'https://i.imgur.com/ETO90Ubb.jpg',
          user_id: @user_1.id
        )
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

      it 'can see the statistics for the shelter' do
        visit "/shelters/#{@shelter_1.id}"

        within "#shelter-statistics" do
          expect(page).to have_content('Total number of pets')
          expect(page).to have_content('3')
          expect(page).to have_content('Average review score')
          expect(page).to have_content('4.7')
          # expect(page).to have_content('Total number of applications')
        end
      end
    end
  end
end
