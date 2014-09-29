# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'a@a.a', password: 'asdasdasd', password_confirmation: 'asdasdasd')

Room.create!(description: 'No Room', rent: 0, area: 0, rentable: true)
Room.create!(description: 'Kitchen', rent: 0, area: 63912, rentable: false)
Room.create!(description: 'Hall', rent: 0, area: 11904, rentable: false)
Room.create!(description: 'Living Room', rent: 0, area: 63215, rentable: false)
Room.create!(description: 'Downstairs Living Room', rent: 0, area: 39240, rentable: false)
Room.create!(description: 'Downstairs Junk room', rent: 0, area: 18000, rentable: false)
Room.create!(description: 'Deck', rent: 0, area: 56640, rentable: false)
Room.create!(description: 'Bobs Room', rent: 0, area: 27648, rentable: true)
Room.create!(description: 'Haleys Room', rent: 0, area: 28500, rentable: true)
Room.create!(description: 'Chris\' Room', rent: 0, area: 21672, rentable: true)
Room.create!(description: 'Master Bedroom', rent: 0, area: 61170, rentable: true)
Room.create!(description: 'Right Downstairs', rent: 0, area: 16100, rentable: true)
Room.create!(description: 'Center Downstairs', rent: 0, area: 17960, rentable: true)
Room.create!(description: 'Left Downstairs', rent: 0, area: 25460, rentable: true)
Room.create!(description: 'Studio Downstairs', rent: 0, area: 22176, rentable: true)
Room.create!(description: 'Garage', rent: 0, area: 61009, rentable: true)
Room.create!(description: 'The Box', rent: 0, area: 18000, rentable: true)

Renter.create!(name: 'Alex Rowe', room_id: 13, phone: '121231', picture: 'alex.png', paid: false)
Renter.create!(name: 'Brent Bruvick', room_id: 12, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Lindsey Brady', room_id: 11, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Haley Bott', room_id: 9, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Chris Taley', room_id: 10, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Chris', room_id: 14, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Lily', room_id: 15, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Wade Hastings', room_id: 17, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Caroline', room_id: 11, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Shawheen Keyani', room_id: 16, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Kevin Hall', room_id: 16, phone: '512331', picture: 'alex.png', paid: true)
Renter.create!(name: 'Liz', room_id: 8, phone: '512331', picture: 'alex.png', paid: true)

House.create!(utilities_id: 1, rent_id: 2, total_area: 512312, total_rent: 4200)