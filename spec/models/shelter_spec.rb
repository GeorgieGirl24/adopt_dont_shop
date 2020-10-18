require 'rails_helper'

describe Shelter do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationship' do
    it { should have_many :pets}
  end

  describe 'instace methods' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349'
      )
      @user_1 = User.create!(
        name: 'Brian',
        street_address: '123 Medival Dr.',
        city: 'Northglenn',
        state: 'CO',
        zip: '80273'
      )
      @user_2 = User.create!(
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
      )

      image_1 = 'https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg'
      image_2 = 'https://icatcare.org/app/uploads/2018/09/white-cat-1.png'
      image_4 = 'https://i.imgur.com/xtu2CYnb.jpg'

      @pet_2 = Pet.create!(
        image: image_1,
        name: 'Misto',
        approximate_age: 12,
        sex: 'Male',
        shelter_id: "#{@shelter_1.id}"
      )
      @pet_3 = Pet.create!(
        image: image_2,
        name: 'Monkey',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
      )
      @pet_4 = Pet.create!(
        image: image_4,
        name: 'Leslie',
        approximate_age: 8,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
      )
      @review_1 = @shelter_1.reviews.create!(
        title: 'Awesome Shelter!',
        rating: '4.5',
        content: 'I love this place! Amazing service!',
        image: 'https://i.imgur.com/FRK6meX.png',
        user_id: @user_1.id
      )
      @review_3 = @shelter_1.reviews.create!(
        title: 'Loved the care of Sophia',
        rating: '4.9',
        content: 'Sophia is an awesome employee. She deserves a raise',
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
      @review_4 = @shelter_1.reviews.create!(
        title: 'Low to Below Average',
        rating: '1.3',
        content: "They didn't loose my cat, but it wasn't great...",
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
    end
    it 'total_pets' do
      expect(@shelter_1.total_pets.round(2)).to eq(3)
    end

    it 'average_review_score' do
      expect(@shelter_1.average_review_score.round(2)).to eq(3.57)
    end
  end
end
