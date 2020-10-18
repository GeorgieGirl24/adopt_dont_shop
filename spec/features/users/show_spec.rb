require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit a User Show page' do
    before :each do
      @shelter_1 = Shelter.create!(
        name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349'
      )
      @shelter_2 = Shelter.create!(
        name: 'Humane Society - Thornton',
        address: '12489 120 St',
        city: 'Thorton',
        state: 'CO',
        zip: '80829'
      )
      @shelter_3 = Shelter.create!(
        name: 'Denver Dumb Friends League',
        address: '54321 Park Ave',
        city: 'Denver',
        state: 'CO',
        zip: '80202'
      )
      @user_1 = User.create!({
        name: 'Brian',
        street_address: '123 Medival Dr.',
        city: 'Northglenn',
        state: 'CO',
        zip: '80273'
      })
      @user_2 = User.create!({
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
      })
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

      @review_3 = @shelter_3.reviews.create!(
        title: 'Awful!',
        rating: '1.5',
        content: 'Worst shelter ever!',
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
        
      @review_4 = @shelter_2.reviews.create!(
        title: 'Loved the care of Sophia',
        rating: '4.9',
        content: 'Sophia is an awesome employee. She deserves a raise',
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
    end

    it 'can see all the Users information' do
      visit "/users/#{@user_1.id}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.street_address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)
      expect(page).to_not have_content(@user_2.name)
    end

    it 'can see every review the unique user has written' do
      visit "/users/#{@user_1.id}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content('Manage Reviews')
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_css("img[src*='#{@review_1.image}']")
      expect(page).to have_content(@review_1.content)
    end

    it 'I can see a section for Highlighted Reviews with best and worst reviews' do
      visit "/users/#{@user_1.id}"
      expect(page).to have_content("Highlighted Reviews")

      within "#highest_rated_review" do
        expect(page).to have_content("Highest Rated Review")
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.content)
        expect(page).to have_content(@review_1.image)
      end

      within "#lowest_rated_review" do
        expect(page).to have_content("Lowest Rated Review")
        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@review_3.content)
        expect(page).to have_content(@review_3.image)
      end

    it 'can see the average of all their reviews' do
      visit "/users/#{@user_1.id}"

      within "#average-review-score" do
        expect(page).to have_content('My average review score')
        expect(page).to have_content('4.3')
      end

    end
  end
end
