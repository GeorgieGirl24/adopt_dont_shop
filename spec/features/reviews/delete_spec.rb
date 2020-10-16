require 'rails_helper'

RSpec.describe 'Delete a Shelter Review' do
  describe 'As a visitor' do
    before :each do
      @shelter_1 = Shelter.create!(
        name: 'Max Fund - Littleton',
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
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
      )
      @user_2 = User.create!(
        name: 'Tahmir Sandivol',
        street_address: '8374 Long Dr. #3',
        city: 'Burlington',
        state: 'VT',
        zip: '29384'
      )
      @review_1 = @shelter_1.reviews.create!(
        title: 'Awesome Shelter!',
        rating: 4.5,
        content: 'I love this place! Amazing service!',
        image: 'https://i.imgur.com/FRK6meX.png',
        shelter: @shelter_1,
        user_id: @user_2.id
      )
      @review_2 = @shelter_1.reviews.create!(
        title: 'Ok',
        rating: 3,
        content: 'Pretty Ok...',
        image: 'https://i.imgur.com/lJYWvvK.jpeg',
        shelter: @shelter_1,
        user_id: @user_1.id
      )
    end

    it 'can see a link next to each shelter review to delete the Review' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)

      within "#review-#{ @review_1.id }" do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.content)
        expect(page).to have_content(@user_2.name)
        expect(page).to have_link('Delete Review')
      end

      within "#review-#{ @review_2.id }" do
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@review_2.content)
        expect(page).to have_content(@user_1.name)
        expect(page).to have_link('Delete Review')
        click_link 'Delete Review'
      end


      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to_not have_content(@review_2.title)
    end
  end
end
