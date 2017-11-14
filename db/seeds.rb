require 'faker'

p "erasing everything"
 Book.destroy_all
 Registration.destroy_all
 User.destroy_all

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

Registration.all.each do |registration|
  params = {}

  params[:number] = 0


    params[:title] = Faker::HarryPotter.book
    params[:content] = Faker::Lovecraft.paragraphs(10).join(" ")
    params[:description] = Faker::HitchhikersGuideToTheGalaxy.marvin_quote
    params[:number] += 1
    chapter = Episode.new(params)
    chapter.book = book

    p chapter
    chapter.save
end

    t.string   "picture"
    t.string   "description"
    t.boolean  "active"
    t.boolean  "author"
    t.string   "fav_genre"
    t.string   "f_name"
    t.string   "l_name"
    t.integer  "registration_id"
    t.boolean  "status"

