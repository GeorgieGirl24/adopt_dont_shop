# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user_2 = User.create!(
  name: 'Natalie Cruz',
  street_address: '7363 Main St.',
  city: 'Seattle',
  state: 'WA',
  zip: '39482'
)
@review = @shelter_1.reviews.create!(title: 'Awesome Staff',
  rating: 4.7,
  content: 'I dropped off Fluffy and the staff was so attentive.',
  image: 'https://imgur.com/gallery/xO0wmxm')

@shelter_1 = Shelter.create!(name: 'Max Fund - Littleton',
  address: '1234 Broadway St',
  city: 'Littleton',
  state: 'CO',
  zip: '82349')
