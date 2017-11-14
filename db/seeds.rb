require 'faker'

p "erasing everything"
 Book.destroy_all
 User.destroy_all
 Registration.destroy_all
 Transaction.destroy_all

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
  book.save
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
    chapter.book = book

    p chapter
    chapter.save
  end
end

p "creating registrations"

10.times do
  registration = Registration.new
  registration.email = Faker::Internet.email
  registration.password = 'password'
  registration.username = Faker::LordOfTheRings.character
  p registration
  registration.save!
end

p "creating users"

Registration.all.each do |registration|
  params = {}
  params[:picture] = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Dwayne_Johnson_2%2C_2013.jpg/220px-Dwayne_Johnson_2%2C_2013.jpg"
  params[:description] = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
  params[:active] = true
  params[:author] = false
  params[:f_name] = Faker::Name.first_name
  params[:l_name] = Faker::Name.last_name
  params[:status] = true
  params[:registration] = registration
  user = User.new(params)
  p user
  user.save
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
    transaction.save
  end
end
