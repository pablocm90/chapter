require 'faker'

p "erasing everything"
 Transaction.destroy_all
 Book.destroy_all
 Review.destroy_all
 Author.destroy_all
 User.destroy_all
 Registration.destroy_all
 Topup.destroy_all

 p "creating 2 users"

 registration = Registration.create(email:"bob@bob", password: "bobbob", username: "bob")
 User.create(registration: registration, tokens: 2000)

 registration_author = Registration.create(email:"bobwritter@bob", password: "bobbob", username: "bobwritter")

 user_author = User.create(registration: registration_author, is_author: true)


  @author = Author.create(user_id: user_author.id, nom_de_plume:"Pablo")

  p @author.user.registration.email
  p @author.user.is_author
  p user_author.registration.email





p "setting counter to 0"

counter = 0
p "creating books"

# genres_array = %w(fantasy scy-fi horror comedy crime thriler)

10.times do

  params = {}
  params[:title] = [Faker::HowIMetYourMother.catch_phrase, Faker::HowIMetYourMother.high_five, Faker::Pokemon.move].sample
  params[:genre] = Book::GENRES.sample
  params[:description] = Faker::StarWars.quote
  params[:quote_hover] = Faker::Pokemon.move
  book = Book.new(params)
  book.author = @author
  if book.save
    counter += 1
    book.save
  end
end

p "created #{counter} books"
counter = 0

p "creating chapters"

Book.all.each do |book|
  params = {}
  params[:number] = 0
  rand(3..7).times do

    params[:title] = Faker::HarryPotter.book
    params[:content] = Faker::Lovecraft.paragraphs(10).join(" ")
    params[:description] = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
    params[:number] += 1
    params[:price] = rand(10..150)
    chapter = Episode.new(params)
    chapter.price = 20
    chapter.book = book
    if chapter.save
      counter += 1
      chapter.save
    end
  end
end

p "created #{counter} chapters"

counter = 0

p "creating registrations"

20.times do
  params = {}
  params[:email] = Faker::Internet.email
  params[:password] = 'password'
  params[:username] = Faker::LordOfTheRings.character
  registration = Registration.new(params)
  if registration.save
    counter += 1
    registration.save
  end
end

p "created #{counter} registrations"

counter = 0


p "creating users"

Registration.all.each do |registration|
  params = {}
  params[:description] = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
  params[:active] = true
  params[:f_name] = Faker::Name.first_name
  params[:l_name] = Faker::Name.last_name
  params[:status] = true
  user = User.new(params)
  user.registration = registration
  if user.save
    counter += 1
    user.save
  end
end

p "created #{counter} users"

counter = 0


p "creating transactions"

User.all.each do |user|
  params = {}

  params[:number] = 0
  rand(3..7).times do
    transaction = Transaction.new
    transaction.user = user
    book = Book.order("RANDOM()").first
    transaction.book = book
    transaction.episode = book.episodes.order("RANDOM()").first
    if transaction.save
      counter += 1
      transaction.save
    end
  end
end
p "created #{counter} transactions"

counter = 0

p "creating reviews"

Book.all.each do |book|
  params = {}
  rand(3..7).times do
    review = Review.new
    review.user = User.order("RANDOM()").first
    review.book = book
    review.rating = rand(0..5)
    review.content = Faker::HarryPotter.quote
    if review.save
      review.save
      counter += 1
    end
  end
end

p "created #{counter} reviews"

counter = 0

p "creating topups"
  topups = {
    "Silver" => 2000,
    "Gold" => 4000,
    "Diamond" => 6000
  }

  topups.each do |key, value|
    topup = Topup.new
    topup.name = key
    topup.price_cents = value
    topup.save
  end

