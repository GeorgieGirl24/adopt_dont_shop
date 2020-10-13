require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit a User Show page' do
    before :each do
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
    end

    it 'can see all the Users information' do
      visit "/#{@user_1.id}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.street_address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)
      expect(page).to_not have_content(@user_2.name)
    end
  end
end
