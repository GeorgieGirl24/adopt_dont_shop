require 'rails_helper'

RSpec.describe Application do
  describe 'validations' do
    it { should validate_presence_of :description}
    it { should validate_presence_of :status }
  end

  describe 'relationship' do
    it { should belong_to :user }
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'instance methods' do
    before :each do
      image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2015/10/Italian-Greyhuahua.jpg"
      image_2 = "https://icatcare.org/app/uploads/2018/09/white-cat-1.png"
      image_3 = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/2560px-Old_English_Sheepdog_%28side%29.jpg"

      @user_1 = User.create!(
        name: 'Natalie Cruz',
        street_address: '7363 Main St.',
        city: 'Seattle',
        state: 'WA',
        zip: '39482'
      )
      @user_2 = User.create!(
        name: 'Tahmir Sandival',
        street_address: '412 Blake St',
        city: 'Los Angeles',
        state: 'CA',
        zip: '90210'
      )
      @shelter_1 = Shelter.create!(
        name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349'
      )
      @shelter_2 = Shelter.create!(
        name: 'Humane Society - Thorton',
        address: '12489 120 St',
        city: 'Thorton',
        state: 'CO',
        zip: '80829'
      )
      @pet_1 = Pet.create!(
        image: image_1,
        name: 'Mollie',
        approximate_age: 6,
        sex: 'Female',
        shelter_id: "#{@shelter_2.id}"
      )
      @pet_2 = Pet.create!(
        image: image_2,
        name: 'Misto',
        approximate_age: 12,
        sex: 'Male',
        shelter_id: "#{@shelter_1.id}"
      )
      @pet_3 = Pet.create!(
        image: image_3,
        name: 'Monkey',
        approximate_age: 12,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
      )
      @status = ['In Progress', 'Pending', 'Accepted', 'Rejected']

      @application_1 = Application.create!(
        description: 'I am great with animals and have a yard',
        status: @status[1],
        user_id: @user_1.id,
      )
      @application_2 = Application.create!(
        description: 'I just love cats but dogs are chill too',
        status: @status[3],
        user_id: @user_2.id
      )

      ApplicationPet.create!(
        pet: @pet_1,
        application: @application_1
        # status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_2,
        application: @application_1
        # status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_2,
        application: @application_2
        # status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_3,
        application: @application_2
        # status: @status[0]
      )
    end
    it '#add_pet' do
      expect(@application_1.pets.count).to eq(2)
    end
  end
end
