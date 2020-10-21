require 'rails_helper'

RSpec.describe 'Admin applications show page' do
  describe 'As a visitor' do
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

      @shelter_1 = Shelter.create!(
        name: 'Max Fund - Littleton',
        address: '1234 Broadway St',
        city: 'Littleton',
        state: 'CO',
        zip: '82349'
      )

      @pet_1 = Pet.create!(
        image: image_1,
        name: 'Mollie',
        approximate_age: 6,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
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
      status = ['In Progress', 'Pending', 'Accepted', 'Rejected']
      description = ["Blank", "Good", "Bad", "Ugly"]

      @application_1 = Application.create!(
        description: description[1],
        user_id: @user_1.id,
        status: status[1]
      )

      @app_pet_1 = ApplicationPet.create!(
        pet_id: @pet_1.id,
        application_id: @application_1.id,
        pet_status: 'Pending'
      )
      @app_pet_2 = ApplicationPet.create!(
        pet_id: @pet_2.id,
        application_id: @application_1.id,
        pet_status: 'Pending'
      )
      @app_pet_3 = ApplicationPet.create!(
        pet_id: @pet_3.id,
        application_id: @application_1.id,
        pet_status: 'Pending'
      )
    end

    it 'I can approve or reject pet-specific applications for each pet' do
      visit "/admin/applications/#{@application_1.id}"
      within "#pet-#{@app_pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_button('Accept Pet')
        # expect(page).to have_button('Reject Pet')
        click_button 'Accept Pet'
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")

        # expect(page).to_not have_content('Accept Pet')
      end
      expect(page).to have_content('Approved')

      # expect(page).to_not have_content('Reject Pet')



      # within "#pet-#{@app_pet_2.id}" do
      #   expect(page).to have_content(@pet_2.name)
      #   expect(page).to have_button('Accept Pet')
      #   expect(page).to have_button('Reject Pet')
      #   click_button 'Reject Pet'
      #   expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      #   expect(page).to_not have_content('Accept Pet')
      #   expect(page).to_not have_content('Reject Pet')
      #   expect(page).to have_content('Rejected')
      # end
      #
      # within "#pet-#{@app_pet_3.id}" do
      #   expect(page).to have_content(@pet_3.name)
      #   expect(page).to have_button('Accept Pet')
      #   expect(page).to have_button('Reject Pet')
      # end
    end
  end
end
