require 'rails_helper'

RSpec.describe 'New user' do
  describe 'As a visitor' do
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
      @user_2 = User.create!(
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
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
        title: 'Blah',
        rating: 3.0,
        content: 'Great',
        image: 'https://i.imgur.com/FRK6meX.png',
        shelter: @shelter_1,
        user_id: @user_2.id
      )
      @review_3 = @shelter_3.reviews.create!(
        title: 'Awful!',
        rating: '1.5',
        content: 'Worst shelter ever!',
        image: '',
        user_id: @user_1.id
      )
    end

    it 'can see a form to create a new user' do
      visit '/users/new'

      fill_in :name, with: @user_2.name
      fill_in :street_address, with: @user_2.street_address
      fill_in :city, with: @user_2.city
      fill_in :state, with: @user_2.state
      fill_in :zip, with: @user_2.zip

      expect(page).to have_button('Create User')

      click_button 'Create User'
      new_user = User.last
      expect(current_path).to eq("/users/#{new_user.id}")
      expect(page).to have_content(@user_2.street_address)
    end
  end
end
