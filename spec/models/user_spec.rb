require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'instance methods' do
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
        city: 'Thornton',
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
      @review_1 = @shelter_1.reviews.create!(
        title: 'Awesome Shelter!',
        rating: '4.5',
        content: 'I love this place! Amazing service!',
        image: 'https://i.imgur.com/FRK6meX.png',
        user_id: @user_1.id
      )
      @review_2 = @shelter_2.reviews.create!(
        title: 'This place is aight',
        rating: '3.5',
        content: 'I mean...its aight, whatever.',
        image: '',
        user_id: @user_1.id
      )
      @review_3 = @shelter_3.reviews.create!(
        title: 'Awful!',
        rating: '1.5',
        content: 'Worst shelter ever!',
        image: '',
        user_id: @user_1.id
      )
    end

    it '#highest_rated_review' do



      expect(@user_1.highest_rated_review).to eq(@review_1.rating)
    end

    it '#lowest_rated_review' do
      expect(@user_1.lowest_rated_review).to eq(@review_3.rating)
    end
  end
end
