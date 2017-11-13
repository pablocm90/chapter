require 'faker'

p "erasing everything"

  Book.destroy_all

p "creating books"



10.times do
  params = {}
  params[:title] = [Faker::HowIMetYourMother.catch_phrase, Faker::HowIMetYourMother.high_five, Faker::Pokemon.move].sample
  params[:genre] = Faker::Book.genre
  params[:description] = Faker::StarWars.quote
  book = Book.new(params)
  book.save
end
