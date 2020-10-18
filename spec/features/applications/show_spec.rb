# require 'rails_helper'
#
# RSpec.describe 'Application Show Page' do
#   describe 'As a visitor' do
#     before :each do
#       @user_2 = User.create!(
#         name: 'Natalie Cruz',
#         street_address: '7363 Main St.',
#         city: 'Seattle',
#         state: 'WA',
#         zip: '39482'
#       )
#       @pet_1 = Pet.create!(image: image_3,
#         name: 'Mollie',
#         approximate_age: 6,
#         sex: 'Female',
#         shelter_id: "#{@shelter_2.id}"
#       )
#       @shelter_1 = Shelter.create!(name: 'Max Fund - Littleton',
#         address: '1234 Broadway St',
#         city: 'Littleton',
#         state: 'CO',
#         zip: '82349'
#       )
#       @shelter_2 = Shelter.create!(name: 'Humane Society - Thorton',
#         address: '12489 120 St',
#         city: 'Thorton',
#         state: 'CO',
#         zip: '80829'
#       )
#       @pet_2 = Pet.create!(image: image_1,
#         name: 'Misto',
#         approximate_age: 12,
#         sex: 'Male',
#         shelter_id: "#{@shelter_1.id}"
#       )
#       @pet_3 = Pet.create!(image: image_2,
#         name: 'Monkey',
#         approximate_age: 12,
#         sex: 'Female',
#         shelter_id: "#{@shelter_1.id}"
#       )
#       @status = ['In Progress', 'Pending', 'Accepted', 'Rejected']
#
#       @application_1 = Application.create!(
#         user_name: @user_2.name,
#         user_address: @user_2.address,
#         description: 'I am great with animals and have a yard',
#         pets: [@pet_1.name, @pet_2.name, @pet_3.name],
#         status: @status[1]
#       )
#     end
#
#
#     # it 'can see all the information needed for an application' do
#     # end
#   end
# end
