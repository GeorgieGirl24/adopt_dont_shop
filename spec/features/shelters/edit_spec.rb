require 'rails_helper'

RSpec.describe 'Shelters New' do
  describe 'As a visitor' do
    before :each do
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

    describe 'When I visit a shelter show page then click the link update the shelter "Update Shelter"' do
      it 'can edit the shelter form' do
        visit "/shelters/#{@shelter_1.id}"
        expect(page).to have_link('Update Shelter')
        click_link 'Update Shelter'
    end
