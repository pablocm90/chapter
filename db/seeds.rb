require 'faker'

p "erasing everything"
 Transaction.destroy_all
 Book.destroy_all
 Review.destroy_all
 Author.destroy_all
 User.destroy_all
 Registration.destroy_all

 p "creating 2 users"

 registration = Registration.create(email:"bob@bob", password: "bobbob", username: "bob")
 User.create(registration: registration)

 registration_author = Registration.create(email:"bobwritter@bob", password: "bobbob", username: "bobwritter")

 user_author = User.create(registration: registration_author, nom_de_plume: "groot")


@author = Author.create(user: user_author, nom_de_plume:"Pablo")




p "creating books"

# genres_array = %w(fantasy scy-fi horror comedy crime thriler)

10.times do

  params = {}
  params[:title] = [Faker::HowIMetYourMother.catch_phrase, Faker::HowIMetYourMother.high_five, Faker::Pokemon.move].sample
  params[:genre] = Book::GENRES.sample
  params[:description] = Faker::StarWars.quote
  params[:quote_hover] = Faker::Pokemon.move
  book = Book.new(params)
  p book
  book.author = @author
  book.save!
end

p "creating chapters"

Book.all.each do |book|
  params = {}

  params[:number] = 0
  rand(3..7).times do

    params[:title] = Faker::HarryPotter.book
    params[:content] = Faker::Lovecraft.paragraphs(10).join(" ")
    params[:description] = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
    params[:number] += 1
    chapter = Episode.new(params)
    chapter.price = 20
    chapter.book = book

    p chapter
    chapter.save!
  end
end

p "creating registrations"

20.times do
  params = {}
  params[:email] = Faker::Internet.email
  params[:password] = 'password'
  params[:username] = Faker::LordOfTheRings.character
  registration = Registration.new(params)
  p registration
  registration.save
end

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
  p user
  user.save!
end

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

    p transaction
    transaction.save!
  end
end

p "creating reviews"

Book.all.each do |book|
  params = {}
  rand(3..7).times do
    review = Review.new
    review.user = User.order("RANDOM()").first
    review.book = book
    review.rating = rand(0..5)
    review.content = Faker::HarryPotter.quote
    p review
    review.save!
  end
end
