require 'rails_helper'

RSpec.describe 'Shelters Show Page' do
  describe 'as a visitor' do
    before :each do
      @jacque_nikkelson = User.create!(name: 'Jacque Nikkelson',
                                       street_address: '123 Medival Dr.',
                                       city: 'Northglenn',
                                       state: 'CO',
                                       zip: '80273'
                                      )

      @tomas_cruz = User.create!(name: 'Tomas Cruz',
                                 street_address: '7363 Main St.',
                                 city: 'Seattle',
                                 state: 'WA',
                                 zip: '39482'
                                )

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


    end

    it 'can see a list of reviews for that shelter' do
      visit "/shelters/#{@shelter_1.id}/reviews"
      @review = @shelter_1.reviews.create!(title: 'Awesome Staff',
        rating: 4.7,
        content: 'I dropped off Fluffy and the staff was so attentive.',
        image: 'https://imgur.com/gallery/xO0wmxm',
        user_id: @review.user_id
      )

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.rating)
      expect(page).to have_css("img[src*='#{@review.image}']")

    end
  end
end
