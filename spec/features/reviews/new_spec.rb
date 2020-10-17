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
     end

     it 'can see a link to add a new review' do
       visit "/shelters/#{@shelter_1.id}"

       expect(page).to have_link('Add a Review')
       click_link 'Add a Review'

       expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

       fill_in :title, with: 'Wicked haaarrrible!'
       fill_in :rating, with: 1.2
       fill_in :content, with: 'The shelters in Boston are much better!'
       fill_in :image, with: 'https://i.imgur.com/AAP67gc.jpeg'
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
      visit "/shelters/#{@shelter_1.id}"

      click_link 'Add a Review'
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      click_button 'Submit'
      expect(page).to have_content('Required information missing. Request not submitted')
      # expect(flash[:alert]).to eq('Required information missing. Request not submitted.')
      # flash[:alert].should_not be_nil

      fill_in :title, with: @review_1.title
      fill_in :rating, with: @review_1.rating
      fill_in :content, with: @review_1.content
      fill_in :image, with: 'https://i.imgur.com/AAP67gc.jpeg'
      fill_in :name, with: @user_2.name
      expect(page).to have_button('Submit')

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content(@review_1.title)
    end
  end
end
