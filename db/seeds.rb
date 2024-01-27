require 'rest-client'
require 'net/http'
require 'json'

puts "Cleaning database..."
Service.destroy_all
User.destroy_all


puts "Creating Martin..."
User.create(
    first_name: "Martin",
    last_name: "Portal",
    email: "mail@mail.com",
    password: "secret",
    password_confirmation: "secret",
  )
puts "done"

# fetching api to create random users with restapi
puts "Creating users..."
10.times do |i|
  url = URI("https://randomuser.me/api/")
  response = Net::HTTP.get(url)
  json = JSON.parse(response)
  results = json["results"]
  results.each do |result|
  User.create(
    first_name: result["name"]["first"],
    last_name: result["name"]["last"],
    email: result["email"],
    picture: result["picture"]["large"],
    password: "password",
    password_confirmation: "password",
  )
  end
end
puts "done"

puts "Creating services..."
10.times do |i|
Service.create!(
  # Name, prices, description
  name: Faker::Lorem.sentence(word_count: 2),
  price_hours: Faker::Number.between(from: 5000, to: 100000),
  description: Faker::Lorem.paragraph(sentence_count: 1),
  user: User.all.sample
)
end
puts "done"

puts "Creating bookings..."
10.times do |i|
Booking.create!(
  # start_date, end_date, status, comment
  comment: Faker::Lorem.paragraph(sentence_count: 1),
  start_date: Faker::Time.between(from: DateTime.now - 5, to: DateTime.now),
  end_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
  status: "pending",
  user: User.all.sample,
  service: Service.all.sample
)
end
puts "done"
