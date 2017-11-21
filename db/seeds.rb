require 'faker'

p "erasing everything"
 Transaction.destroy_all
 Book.destroy_all
 Review.destroy_all
 Author.destroy_all
 User.destroy_all
 Registration.destroy_all
 Topup.destroy_all

p "creating show book"
  contents = File.read('filename')

p "creating main user"

  registration_author = Registration.create(email:"alexandre@dumas", password: "aramis", username: "Alex")

  user_author = registration_author.user

  user_author.update(f_name: "Alexandre", l_name: "Dumas", is_author: true, tokens: 1000, fav_genre: "drama", description: "Alexandre Dumas was born on July 24, 1802, in Villers-Cotterêts, France. He adopted the last name 'Dumas' from his grandmother, a former Haitian slave. Dumas established himself as one of the most popular and prolific authors in France, known for plays and historical adventure novels such as The Three Musketeers and The Count of Monte Cristo. He died on December 5, 1870, in Puys, France. His works have been translated into more than 100 languages and adapted for numerous films." )

  user_author.save

  p user_author


  @author = Author.new(user_id: user_author.id, nom_de_plume: "Alexandre", bank_account: "46543268451")

  p @author
  p @author.user.registration.email
  p @author.user.is_author
  p user_author.registration.email

p "creating rest of users"
20.times do
  username = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  registration = Registration.new(username: username, email: email, password: password)
  registration_user = registration.user
  registration_user.save
end


p "creating main book"


url = "http://static.giantbomb.com/uploads/original/9/99864/2419866-nes_console_set.png"

main_book.title = "The Three Musketeers"
main_book.description = "D'Artagnan arrives in Paris and, seeking to join the king's musketeers, goes to see their captain, Tréville. In his haste he offends three of the best musketeers—Porthos, Athos, and Aramis—and challenges each to a duel that afternoon."
main_book.genre = "historical-fiction"
main_book.tags = "three, musketeers, fiction, dumas"
main_book.remote_cover_pic_url = url
main_book.quote_hover = "Love is the most selfish of all the passions."

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
    topup.sku = key.downcase
    topup.price_cents = value
    topup.tokens = value * 0.007
    topup.save
  end

