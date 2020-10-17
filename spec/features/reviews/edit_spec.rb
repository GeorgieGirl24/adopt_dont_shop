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
      @user_2 = User.create!(
        name: 'Tahmir Sandivol',
        street_address: '8374 Long Dr. #3',
        city: 'Burlington',
        state: 'VT',
        zip: '29384'
      )
      @user_3 = User.create!(
        name: 'Tom Sandival',
        street_address: '8374 Long Dr. #3',
        city: 'Dover',
        state: 'DE',
        zip: '22341'
      )
    @review_1 = @shelter_1.reviews.create!(
      title: 'Awesome Shelter!',
      rating: 4.5,
      content: 'I love this place! Amazing service!',
      image: 'https://i.imgur.com/FRK6meX.png',
      user_id: @user_1.id
    )
    @review_2 = @shelter_1.reviews.create!(
      title: 'Negative!',
      rating: 0.0,
      content: 'Hate',
      image: '',
      user_id: @user_2.id
    )
    @review_3 = @shelter_1.reviews.create!(
      title: 'Blah',
      rating: 3.0,
      content: 'Neutral',
      image: '',
      user_id: @user_3.id
    )
    end
    it 'can see a link in order to edit my review' do
      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{@review_3.id}" do
        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@review_3.content)
        expect(page).to have_content(@review_3.image)
        expect(page).to have_content(@user_3.name)
      end

      within "#review-#{@review_1.id}" do
        expect(page).to have_content(@user_1.name)

        expect(page).to have_link('Edit Review')
        click_link 'Edit Review'
      end

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

      expect(find_field(:title).value).to eq @review_1.title
      expect(find_field(:rating).value).to eq @review_1.rating.to_s
      expect(find_field(:content).value).to eq @review_1.content
      expect(find_field(:image).value).to eq @review_1.image
      expect(find_field(:name).value).to eq @user_1.name


      fill_in :title, with: 'SO WONDERFUL!'
      fill_in :rating, with: 5.0
      fill_in :name, with: @user_2.name

      expect(page).to have_button('Update Review')
      click_button 'Update Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content('SO WONDERFUL!')
      expect(page).to have_content(@user_2.name)
      expect(page).to have_content(@user_3.name)
    end

    it 'can not edit a review and a leave a field blank' do
      visit "/reviews/#{@review_1.id}/edit"

      expect(find_field(:title).value).to eq @review_1.title
      fill_in :title, with: ''
      expect(find_field(:rating).value).to eq @review_1.rating.to_s
      expect(find_field(:content).value).to eq @review_1.content
      expect(find_field(:image).value).to eq @review_1.image
      expect(find_field(:name).value).to eq @user_1.name

      click_button 'Update Review'

      expect(page).to have_content('Empty Field. Please try again.')

      fill_in :title, with: 'Great Job!'
      click_button 'Update Review'

      expect(current_path).to eq "/shelters/#{@shelter_1.id}"
      expect(page).to have_content('Great Job!')
    end

    it 'must have a valid user to complete the edit form' do
      visit "/shelters/#{@shelter_1.id}"

      within "#review-#{@review_1.id}" do
        click_link 'Edit Review'
      end
      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

      expect(find_field(:title).value).to eq @review_1.title
      expect(find_field(:rating).value).to eq @review_1.rating.to_s
      expect(find_field(:content).value).to eq @review_1.content
      expect(find_field(:image).value).to eq @review_1.image
      fill_in :name, with: 'Godfrey'

      click_button 'Update Review'
      expect(page).to have_content("That name doesn't exisit in our database. You must be a valid user.")

      fill_in :name, with: @user_2.name
      click_button 'Update Review'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content(@user_2.name)
    end
  end
end
