class BooksController < ApplicationController
  # The show method displays only further details on a single book
  # Find only the book that has the id defined in params[:id]
  skip_before_action :authenticate_registration!, only: [:index, :show, :search]

  def show
   @book = Book.find(params[:id])
   @review = Review.new
 end

 def search
    # onder index te plaatsen
    Book.reindex
    @books = (params[:query].present?) ? Book.search(params[:query]) : Book.all
    sort_results(@books)
  end

  def index
    @books = Book.all
  end

  def buy
    @book = Book.find(params[:id])
  end


private

  def sort_results(data)
    @ordered_books = data.sort_by { |book| average_rating(book) }
    @ordered_books.reverse!
  end

  def average_rating(book)
    book.reviews.count != 0 ? @average_rating = book.reviews.average(:rating) : @average_rating = 0
  end

end
