require 'rails_helper'

describe Pet do
  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'validations' do
    it { should validate_presence_of :shelter_id }
  end

  describe 'instance methods' do
    before :each do
      image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg"
      image_2 = "https://icatcare.org/app/uploads/2018/09/white-cat-1.png"
      image_3 = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg"

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
      @user_2 = User.create!({
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
      })
      @pet_1 = Pet.create!(
        image: image_3,
        name: 'Mollie',
        description: 'Old English Sheepdog with a bright personality and two different colored eyes',
        approximate_age: 6,
        sex: 'Female',
        shelter_id: "#{@shelter_2.id}",
        adoptable: false
      )
      @pet_2 = Pet.create!(
        image: image_1,
        name: 'Misto',
        description: 'Chichuahua, miniture Italian Grey that is a little skiddish, but so sweet',
        approximate_age: 12,
        sex: 'Male',
        shelter_id: "#{@shelter_1.id}",
        adoptable: true
      )
      @pet_3 = Pet.create!(
        image: image_2,
        name: 'Monkey',
        description: 'All white cat with green eyes, that is a total cuddlebug',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}",
        adoptable: false
      )
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
      @review_4 = @shelter_2.reviews.create!(
        title: 'Loved the care of Sophia',
        rating: '4.9',
        content: 'Sophia is an awesome employee. She deserves a raise',
        image: 'https://i.imgur.com/ETO90Ubb.jpg',
        user_id: @user_1.id
      )
      @review_3 = @shelter_3.reviews.create!(
        title: 'Awful!',
        rating: '1.5',
        content: 'Worst shelter ever!',
        image: '',
        user_id: @user_1.id
      )
     @highest_review = {
          title: @review_4.title,
          rating: @review_4.rating,
          content: @review_4.content,
          image: @review_4.image
      }
      @lowest_review = {
        title: @review_3.title,
        rating: @review_3.rating,
        content: @review_3.content,
        image: @review_3.image
      }
    end

    it '#search' do
      Pet.search(@pet_1.name).should eq([@pet_1])
    end

  end
end
