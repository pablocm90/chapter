require 'faker'

p "erasing everything"
 Transaction.destroy_all
 Book.destroy_all
 Review.destroy_all
 Author.destroy_all
 User.destroy_all
 Registration.destroy_all
 Topup.destroy_all

p "setting counter to 0"

counter = 0
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
  if registration_user.save
    registration_user.save
    counter += 1
  end
end

p "created #{counter} users"

counter = 0

p "creating main book"


url = "http://blog.catherinedelors.com/wp-content/uploads/Paris-Port-au-ble.jpg"

main_book.title = "The Three Musketeers"
main_book.description = "D'Artagnan arrives in Paris and, seeking to join the king's musketeers, goes to see their captain, Tréville. In his haste he offends three of the best musketeers—Porthos, Athos, and Aramis—and challenges each to a duel that afternoon."
main_book.genre = "historical-fiction"
main_book.tags = "three, musketeers, fiction, dumas"
main_book.remote_cover_pic_url = url
main_book.quote_hover = "Love is the most selfish of all the passions."

p "saved main book" if main_book.save
  main_book.save

p "populating main book"
  content_split = content.split("+++")
  content_split.each_with_index do |part, index|
    if index % 3 == 0
      episode = Episode.new(title: part, content: content_split[index + 1], description: content_split[index + 2], price: rand(20..40))
    end
    if episode.save
      counter += 1
      episode.save
    end
  end
p "it has #{counter} chapters"

counter = 0

p "creating books"

# genres_array = %w(fantasy scy-fi horror comedy crime thriler)
titles = {
  "A Division of the Spoils" => "https://img00.deviantart.net/ff57/i/2011/186/e/7/property_condemner_by_the_spoils_art_team-d3l1ikb.jpg",
  "The Towers of Silence" => "https://i.ytimg.com/vi/zD9fPhHkXhk/maxresdefault.jpg",
  "The Secret of Santa Vittoria" => "http://www.itnnews.lk/wp-content/uploads/2016/04/secrets-peter-thiel-zero-to-one-startups1.jpg",
  "The Shooting Party" => "http://media.graytvinc.com/images/810*456/shooting+2+mgn37.jpg",
  "The Power of the Dog" => "https://orig00.deviantart.net/366e/f/2011/348/8/8/dance_of_the_ghosts_by_pineapple_power_dog-d4j2ovq.jpg",
  "Southern Mail" => "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/HerdQuit.jpg/1200px-HerdQuit.jpg",
  "A Dram of Poison" => "https://steampunkopera.files.wordpress.com/2012/06/fn1.jpg",
  "The Chess Garden" => "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Chess_pawn_0968.jpg/1200px-Chess_pawn_0968.jpg",
  "Five Plays" => "https://upload.wikimedia.org/wikipedia/commons/5/56/Theater_Baden-Baden-22-gje.jpg",
  "Winter Birds" => "https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/49_20HQOeijh9fog1/dead-bird-dead-magpie_v_gew7p_l__S0000.jpg",
  }

books_populate = []

titles.each do |title, picture|
  url = picture
  book = Book.new()
  book.remote_cover_pic_url = url
  book.genre = Book::GENRES.sample
  book.description = Faker::HitchhikersGuideToTheGalaxy.quote
  book.quote_hover = Faker::VForVendetta.quote
  book.author = @author
  if book.save
    counter += 1
    book.save
    books_populate << book
  end
end

p "created #{counter} books"

counter = 0

p "creating chapters"

books_populate.each do |book|
  params = {}
  params[:number] = 0
  rand(3..7).times do

    params[:title] = Faker::Book.title
    params[:content] = Faker::Lorem.paragraph(10)
    params[:description] = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
    params[:number] += 1
    params[:price] = rand(20..40)
    chapter = Episode.new(params)
    chapter.book = book
    if chapter.save
      counter += 1
      chapter.save
    end
  end
end

p "created #{counter} chapters"

counter = 0


p "creating transactions"

User.all.each do |user|
  params = {}

  params[:number] = 0
  rand(10..20).times do
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

