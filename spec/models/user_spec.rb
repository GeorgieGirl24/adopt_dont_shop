require 'rails_helper'

describe User do
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
      city: 'Thorton',
      state: 'CO',
      zip: '80829'
    )
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
    @review_3 = @shelter_2.reviews.create!(
      title: 'Loved the care of Sophia',
      rating: '4.9',
      content: 'Sophia is an awesome employee. She deserves a raise',
      image: 'https://i.imgur.com/ETO90Ubb.jpg',
      user_id: @user_1.id
    )

  end
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'instance method' do
    it 'average_review_score' do
      expect(@user_1.average_review_score.round(2)).to eq(4.3)
    end
  end
end
