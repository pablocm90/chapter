require 'faker'

p "erasing everything"

  Book.destroy_all

p "creating books"

background-images = ['assets/img-1.jpg', 'assets/img-2.jpeg', 'assets/img-3.jpeg','assets/img-4.jpeg']

10.times do
  params = {}
  params[:title] = [Faker::HowIMetYourMother.catch_phrase, Faker::HowIMetYourMother.high_five, Faker::Pokemon.move].sample
  params[:genre] = Faker::Book.genre
  params[:description] = Faker::StarWars.quote
  params[:cover_pic] = background-images.sample
  book = Book.new(params)
  book.save
end
