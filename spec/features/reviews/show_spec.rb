require 'rails_helper'

RSpec.describe 'Shelter reviews show page' do
  describe 'As a visitor' do
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
                                   zip: '82349'
                                                         )
      @shelter_2 = Shelter.create!(name: 'Humane Society - Thornton',
                                   address: '12489 120 St',
                                   city: 'Thorton',
                                   state: 'CO',
                                   zip: '80829'
                                                         )
      @review_1 = @shelter_1.reviews.create!(title: 'Awesome Shelter!',
                                rating: '4.5',
                                content: 'I love this place! Amazing service!',
                                image: 'https://i.imgur.com/FRK6meX.png',
                                user_id: @jacque_nikkelson.id
                              )
      @review_2 = @shelter_2.reviews.create!(title: 'This place is aight',
                                rating: '3.5',
                                content: 'I mean...its aight, whatever.',
                                image: 'https://icatcare.org/app/uploads/2018/09/white-cat-1.png',
                                user_id: @tomas_cruz.id
                              )
    end

    it 'can see a list of reviews for that shelter' do
      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.rating)
      expect(page).to have_content(@review_2.content)
      expect(page).to have_css("img[src*='#{@review_2.image}']")
      expect(page).to have_content(@tomas_cruz.name)
    end
  end
end
