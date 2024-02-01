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

events = [
  {name: "Sake Sips in Yokohama", description: "Savor traditional sake varieties while soaking in Yokohama's stunning bay views, guided by local experts sharing the history and craftsmanship behind each brew."},
  {name: "Tokyo Terroir Discovery", description: "Delve into Tokyo's diverse terroir with a tasting led by a sommelier, featuring unique wines that reflect the city's distinct microclimates and soil compositions."},
  {name: "Bold Bordeaux Experience", description: "Experience the boldness of Bordeaux with a tasting led by a sommelier, featuring classic blends and single-varietal expressions from renowned appellations."},
  {name: "Kyoto Wine Kaleidoscope", description: "Experience Kyoto's wine kaleidoscope, exploring a diverse array of Japanese wines paired with traditional Kyoto cuisine, guided by knowledgeable sommeliers."},
  {name: "Burgundy Bonanza in Tokyo", description: "Experience the beauty of Burgundy in Tokyo, with a curated tasting highlighting the elegance and complexity of Burgundian wines paired with gourmet bites."},
  {name: "Osaka Oenophile Outing", description: "Discover Osaka's wine scene with an exclusive tasting event showcasing local favorites and international gems, accompanied by Osaka-style street food delights."},
  {name: "Kanagawa Wine Walk", description: "Explore Kanagawa's wine scene, from boutique vineyards to urban wine bars, sampling a diverse selection of varietals and learning about the region's winemaking history."},
  {name: "Chardonnay Chill in Kawasaki", description: "Unwind with Chardonnay in Kawasaki, where expert sommeliers lead a relaxed tasting session featuring premium labels and insider tips on food pairings."},
  {name: "Sparkling Spectacular Showcase", description: "Indulge in a spectacular showcase of sparkling wines from around the world, curated by a sommelier to dazzle your senses and elevate your appreciation."},
  {name: "Japanese Wine Wonderland", description: "Journey through Japan's burgeoning wine scene with a sommelier as your guide, sampling a diverse selection of wines from Hokkaido to Okinawa, each reflecting the unique terroir and craftsmanship of its region."},
]

selected_event = events.sample

10.times do |i|
Service.create!(
  # Name, prices, description
  name: selected_event[:name],
  price_hours: Faker::Number.between(from: 2000, to: 30_000),
  description: selected_event[:description],
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
