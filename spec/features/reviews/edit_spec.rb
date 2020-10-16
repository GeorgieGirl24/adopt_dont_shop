require 'rails_helper'

RSpec.describe 'Edit a Shelter Review' do
  describe 'As a visitor' do
    before :each do
      @shelter_1 = Shelter.create!(
        name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349'
      )

      @user_1 = User.create!(
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
      user_id: @user_1.id
    )
    end
    it 'can see a link in order to edit my review' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@user_1.name)

      expect(page).to have_link('Edit Review')
      click_link 'Edit Review'

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

      expect(find_field(:title).value).to eq @review_1.title
      expect(find_field(:rating).value).to eq @review_1.rating.to_s
      expect(find_field(:content).value).to eq @review_1.content
      expect(find_field(:image).value).to eq @review_1.image
      expect(find_field(:name).value).to eq @user_1.name

      fill_in :title, with: 'SO WONDERFUL!'
      fill_in :rating, with: 5.0

      expect(page).to have_button('Update Review')
      click_button 'Update Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('SO WONDERFUL!')
    end
  end
end
