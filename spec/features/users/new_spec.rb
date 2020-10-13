require 'rails_helper'

RSpec.describe 'New user' do
  describe 'As a visitor' do
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
    it 'can see a form to create a new user' do
      visit '/users/new'

      fill_in :name, with: @user_2.name
      fill_in :street_address, with: @user_2.street_address
      fill_in :city, with: @user_2.city
      fill_in :state, with: @user_2.state
      fill_in :zip, with: @user_2.zip

      expect(page).to have_button('Create User')

      click_button 'Create User'

      expect(current_path).to eq("/users/#{@user_2.id}")
      expect(page).to have_content(@user_2.street_address)
    end
  end
end
