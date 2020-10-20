require 'rails_helper'

RSpec.describe 'Application Show Page' do
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
      @pet_4 = Pet.create!(
        image: '',
        name: 'Misto',
        approximate_age: 10,
        sex: 'Female',
        shelter_id: "#{@shelter_1.id}"
      )
      @status = ['In Progress', 'Pending', 'Accepted', 'Rejected']
      @description = ["Blank", "Good", "Bad", "Ugly"]
      @application_1 = Application.create!(
        description: @description[0],
        user_id: @user_1.id,
        status: @status[0]
      )
      @application_2 = Application.create!(
        description: 'I just love cats but dogs are chill too',
        user_id: @user_2.id,
        status: @status[0]
      )
      @application_3 = Application.create!(
        description: 'I just love cats but dogs are chill too',
        user_id: @user_1.id,
        status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_1,
        application: @application_1,
        pet_status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_2,
        application: @application_1,
        pet_status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_2,
        application: @application_2,
        pet_status: @status[0]
      )
      ApplicationPet.create!(
        pet: @pet_3,
        application: @application_2,
        pet_status: @status[0]
      )
    end


    it 'can see a name to start an application' do
      visit "/applications/#{@application_1.id}"

      within "#user-info" do
        expect(page).to have_content(@user_1.name)
        expect(page).to have_content(@user_1.address)
      end

      within "#application-info" do
        # expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@application_1.pets[0].name)
        expect(page).to have_link(@application_1.pets[0].name)
        expect(page).to have_content(@application_1.status)
      end
    end

    it 'I can see a link to start an application from the pet index page' do
      visit '/pets'

      expect(page).to have_link('Start an Application')
      click_link 'Start an Application'
      expect(current_path).to eq('/applications/new')
      fill_in :name, with: @user_1.name
      expect(page).to have_button('Submit')
      click_button 'Submit'
      expect(current_path).to eq("/applications/#{@user_1.applications.last.id}")

      within '#user-info' do
        expect(page).to have_content(@user_1.name)
        expect(page).to have_content(@user_1.address)
      end

      within '#application-info' do
        expect(page).to have_content('In Progress')
      end
    end

    it 'can search for a pet' do
      visit "/applications/#{@application_2.id}"

      within '#application-info' do
        expect(page).to have_content('In Progress')
      end

      within '#add-pet' do
        expect(page).to have_content('Add a Pet to this Application')

        fill_in 'Search Pets', with: @pet_2.name
        click_button 'Submit'

        expect(current_path).to eq("/applications/#{@application_2.id}")
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content(@pet_4.name)
        expect(page).to have_content(@pet_4.description)
        expect(page).to have_content(@pet_2.approximate_age)
        expect(page).to have_css("img[src*='#{@pet_2.image}']")
        expect(page).to have_content(@pet_2.description)
        expect(page).to have_content(@pet_2.sex)
      end
    end

    it 'can adopt a pet by clicking the Adopt this Pet button' do
      visit "/applications/#{@application_3.id}"

      fill_in 'Search Pets', with: @pet_4.name
      click_button 'Submit'

      within "#pet-#{@pet_4.id}" do
        expect(page).to have_content(@pet_4.name)
        expect(page).to have_button('Adopt this Pet')
        click_button 'Adopt this Pet'
        expect(current_path).to eq("/applications/#{@application_3.id}")
      end

      within '#application-info' do
        expect(page).to have_content(@pet_4.name)
      end
    end
    describe 'we are trying something here ' do
      it 'can input a description as to why the User would be a good pet parent' do
        visit "/applications/#{@application_1.id}"


        fill_in 'Search Pets', with: @pet_1.name
        click_button 'Submit'

        within "#pet-#{@pet_1.id}" do
          click_button 'Adopt this Pet'
          expect(current_path).to eq("/applications/#{@application_1.id}")
        end

        within "#application-info" do
          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
        end

        within "#description-info" do
          fill_in :description, with: 'I love pets and I have a large backyard'
          click_button 'Submit Application'
          expect(current_path).to eq("/applications/#{@application_1.id}")
        end

        expect(@application_1.pets.count).to eq(3)
        within "#application-info" do
          expect(page).to have_content('I love pets and I have a large backyard')
        end

        expect(page).to have_content('Pending')

        expect(page).to_not have_content('Add a Pet to this Application')
      end
    end

    it 'can not see a submit application unless there are pets selected' do
      visit "/applications/#{@application_2.id}"

      expect(page).to_not have_content(:description)
      expect(page).to_not have_button 'Submit this Application'
    end
  end

end
