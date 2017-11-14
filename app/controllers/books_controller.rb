class BooksController < ApplicationController
  # The show method displays only further details on a single book
  # Find only the book that has the id defined in params[:id]
  def show
     @book = Book.find(params[:id])
  end


  def search
    # onder index te plaatsen
    Book.reindex
    @books = (params[:query].present?) ? Book.search(params[:query]) : Book.all
    # sort_results(@books)
  end

  def index
    @books = Book.all
  end

end
