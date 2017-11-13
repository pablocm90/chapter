class BooksController < ApplicationController


  def search
    # onder index te plaatsen
    Book.reindex
    @books = (params[:query].present?) ? Book.search(params[:query]) : Book.all
    # sort_results(@books)

  def index
    @books = Book.all

  end
end
