class PagesController < ApplicationController
  skip_before_action :authenticate_registration!
  def home
    @books = Book.all
    sort_results(@books)
  end

private

  def sort_results(data)
    @ordered_books = data.sort_by { |book| average_rating(book) }
    @ordered_books.reverse!
  end

  def average_rating(book)
    book.reviews.count != 0 ? @average_rating = book.reviews.average(:rating).round(0) : @average_rating = 0
  end

end
