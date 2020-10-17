require 'rails_helper'

RSpec.describe 'Shelter Review Creation' do
  describe 'As a visitor' do
     before :each do
       @shelter_1 = Shelter.create!(
         name: 'Max Fund - Littleton',
         address: '1234 Broadway St',
         city: 'Littleton',
         state: 'CO',
         zip: '82349'
       )

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
     end

     it 'can see a link to add a new review' do
       visit "/shelters/#{@shelter_1.id}"

       expect(page).to have_link('Add a Review')
       click_link 'Add a Review'

       expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

       fill_in :title, with: @review_1.title
       fill_in :rating, with: @review_1.rating
       fill_in :content, with: @review_1.content
       fill_in :image, with: @review_1.image
       fill_in :name, with: @user_2.name
       expect(page).to have_button('Submit')

       click_button 'Submit'

       expect(current_path).to eq("/shelters/#{@shelter_1.id}")

       new_review = Review.last

       expect(page).to have_content(new_review.title)
       expect(page).to have_content(new_review.rating)
       expect(page).to have_content(new_review.content)
       expect(page).to have_css("img[src*='#{new_review.image}']")
       expect(page).to have_content('Natalie Cruz')
    end

    it 'needs to fill in title, rating and/or content, else a flash message will appear' do
      visit "/shelters/#{@shelter_1.id}/reviews/new"

      fill_in :title, with: @review_2.title
      fill_in :content, with: @review_2.content
      fill_in :rating, with: ''
      fill_in :name, with: @user_2.name

      expect(find_field(:content).value).to eq @review_2.content

      expect(find_field(:name).value).to eq @user_2.name
      expect(page).to have_button('Submit')
      click_button 'Submit'

      expect(page).to have_content('Required information missing. Request not submitted')

      fill_in :title, with: @review_2.title
      fill_in :rating, with: @review_2.rating
      fill_in :content, with: @review_2.content
      fill_in :image, with: 'https://i.imgur.com/AAP67gc.jpeg'
      fill_in :name, with: @user_2.name
      expect(page).to have_button('Submit')

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content(@review_2.title)
    end

    it 'can not complete a review if the user is not in the database' do
      visit "/shelters/#{@shelter_1.id}"

      click_link 'Add a Review'
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in :title, with: @review_1.title
      fill_in :rating, with: @review_1.rating
      fill_in :content, with: @review_1.content
      fill_in :image, with: 'https://i.imgur.com/AAP67gc.jpeg'
      fill_in :name, with: 'Godfrey'

      click_button 'Submit'
      expect(page).to have_content("That name doesn't exisit in our database. You must be a valid user.")

      fill_in :title, with: @review_1.title
      fill_in :rating, with: @review_1.rating
      fill_in :content, with: @review_1.content
      fill_in :image, with: 'https://i.imgur.com/AAP67gc.jpeg'
      fill_in :name, with: @user_2.name
      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content(@user_2.name)
    end
  end
end
