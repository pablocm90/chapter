require 'faker'

p "erasing everything"
 Book.destroy_all

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
  rand(3..7).times do
    params = {}

    params[:number] = 1
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


