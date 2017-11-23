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
  contents = File.read('db/book.txt')

p "creating dumas"
  url = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Alexander_Dumas_p%C3%A8re_par_Nadar_-_Google_Art_Project.jpg/220px-Alexander_Dumas_p%C3%A8re_par_Nadar_-_Google_Art_Project.jpg"

  registration_author = Registration.create(email:"alexandre@dumas", password: "aramis", username: "Alex")

  user_author = registration_author.user
  user_author.remote_picture_url = url

  user_author.update(f_name: "Alexandre", l_name: "Dumas", is_author: true, tokens: 1000, fav_genre: "drama", description: "Alexandre Dumas was born on July 24, 1802, in Villers-Cotterêts, France. He adopted the last name 'Dumas' from his grandmother, a former Haitian slave. Dumas established himself as one of the most popular and prolific authors in France, known for plays and historical adventure novels such as The Three Musketeers and The Count of Monte Cristo." )

  user_author.save

  @author = Author.new(user_id: user_author.id, nom_de_plume: "Alexandre Dumas", bank_account: "46543268451")
  @author.save

  p "creating main author"

  url = "http://res.cloudinary.com/dpqd2snsv/image/upload/v1511457257/P1010205_n7yoi8.png"

  registration_main_author = Registration.create(email:"pablo@pablo", password: "pablito", username: "Pablocm90")

  user_main_author = registration_main_author.user
  user_main_author.remote_picture_url = url

  user_main_author.update(f_name: "Pablo", l_name: "Curell", is_author: true, tokens: 1000, fav_genre: "drama", description: "Pablo Curell is an aspiring writter and developer, when not writing or coding he likes to spend time on chapter.website catching up with other people's work." )

  user_main_author.save



  @main_author = Author.new(user_id: user_main_author.id, nom_de_plume: "Pablo Curell Mompo", bank_account: "46543268451")

  @main_author.save

p "creating rest of users"

users_pictures = {
  "AlexVaca" => "https://avatars2.githubusercontent.com/u/31826596?v=4",
  "CarmenLongo" => "https://avatars2.githubusercontent.com/u/31891782?v=4",
  "ChrisTalib" => "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/ry7ys9cfi7wn4hc0kfao.jpg",
  "DiogoHeinen" => "https://avatars1.githubusercontent.com/u/18058374?v=4",
  "HasnaOulad" => "https://avatars3.githubusercontent.com/u/32149575?v=4",
  "JJPadilla" => "https://avatars2.githubusercontent.com/u/29815901?v=4",
  "KeThienNguyen" => "https://avatars2.githubusercontent.com/u/31991540?v=4",
  "LouisePicot" => "https://avatars3.githubusercontent.com/u/22460942?v=4",
  "LucJerome" => "https://avatars0.githubusercontent.com/u/32061433?v=4",
  "MadelineOleary" => "https://avatars3.githubusercontent.com/u/13802104?v=4",
  "MaximPiessen" => "https://avatars2.githubusercontent.com/u/31801298?v=4",
  "PhilippeKnafo" => "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/vkjrmeilwttufrudjxth.jpg",
  "PierreCollinet" => "https://avatars3.githubusercontent.com/u/19423603?v=4",
  "RemiEvrardDaTroa" => "https://avatars2.githubusercontent.com/u/12064658?v=4",
  "ReginalDeWasseige" => "https://avatars2.githubusercontent.com/u/30596794?v=4",
  "SashaDeLaet" => "https://avatars1.githubusercontent.com/u/30638967?v=4",
  "TheodoreWillems" => "https://avatars0.githubusercontent.com/u/32134216?v=4",
  "ThomasSohet" => "https://avatars2.githubusercontent.com/u/29751630?v=4",
  "YassBarona" => "https://avatars3.githubusercontent.com/u/27958519?v=4",

}

user_counter = 0

review_users = []
transaction_users = []

users_pictures.each do |user, picture|
  username = user
  email = Faker::Internet.email(user)
  url = picture
  password = "password"
  registration = Registration.new(username: username, email: email, password: password)
  if registration.save
    registration.save
    counter += 1
  end
  user = registration.user
  user.remote_picture_url = url
  if user.save
    user_counter += 1
    user.save
    review_users << user
    transaction_users << user
  end
end
p "created #{counter} Registrations and #{user_counter} Users"

counter = 0
40.times do
  username = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  registration = Registration.new(username: username, email: email, password: password)
  if registration.save
    registration.save
    transaction_users << registration.user
    counter += 1
  end
end

p "created #{counter} Registrations"

counter = 0



p "creating main book"


url = "http://blog.catherinedelors.com/wp-content/uploads/Paris-Port-au-ble.jpg"
main_book = Book.new()
main_book.title = "The Three Musketeers"
main_book.description = "D'Artagnan arrives in Paris and, seeking to join the king's musketeers, goes to see their captain, Tréville. In his haste he offends three of the best musketeers—Porthos, Athos, and Aramis—and challenges each to a duel that afternoon."
main_book.genre = "historical-fiction"
main_book.tags = "three, musketeers, fiction, dumas"
main_book.remote_cover_pic_url = url
main_book.quote_hover = "Love is the most selfish of all the passions."
main_book.author = @author
p "saved main book" if main_book.save
  main_book.save

p "populating main book"
  content_split = contents.split("+++")
  number = 0
  content_split.each_with_index do |part, index|

    if index % 3 == 0
      episode = Episode.new(title: content_split[index + 1], content: content_split[index + 2], description: content_split[index + 3], price: rand(20..40), book_id: main_book.id)
      number += 1
      episode.number = number
       p episode
      if episode.save
        p "this one saved"
        counter += 1
        episode.save
      end
    end
  end
p "it has #{counter} chapters"

p "user_main_author owns 3 chapters of the three musketeers"

main_book.episodes.order(:number)[0..2].each do |episode|

  Transaction.create(user: user_main_author, book: main_book, episode: episode)

end

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
  p url
  book = Book.new()
  book.title = title
  book.remote_cover_pic_url = url
  book.genre = Book::GENRES.sample
  book.description = Faker::HitchhikersGuideToTheGalaxy.quote
  book.quote_hover = Faker::HarryPotter.quote
  book.author = [@author, @main_author, @author].sample
  p book
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
    params[:price] = rand(45..70)
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

transaction_users.each do |user|
  Book.all.each do |book|
    probability = 85
    book.episodes.order(:number).each do |episode|
      if rand(0..100) < probability
        transaction = Transaction.new
        transaction.user = user
        transaction.book = book
        transaction.episode = episode
        probability -= 10
        if transaction.save
          counter += 1
          transaction.save
        end
      end
    end
  end
end


p "created #{counter} transactions"

counter = 0

p "creating reviews"

Book.all.each do |book|
  params = {}
  rand(10..50).times do
    review = Review.new
    review.user = review_users.sample
    review.book = book
    review.rating = rand(3..5)
    review.content = Faker::HarryPotter.quote
    if review.save
      review.save
      counter += 1
    end
  end
end
Book.reindex

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

