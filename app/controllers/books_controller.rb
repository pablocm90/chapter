class BooksController < ApplicationController
  # The show method displays only further details on a single book
  # Find only the book that has the id defined in params[:id]
  skip_before_action :authenticate_registration!, only: [:index, :show, :search]

  def show
   @book = Book.find(params[:id])
 end

 def search
    # onder index te plaatsen
    raise
    Book.reindex
    @books = (params[:query].present?) ? Book.search(params[:query]) : Book.all
    # sort_results(@books)
  end

  def index
    @books = Book.all
  end

  def buy
    @book = Book.find(params[:id])
  end

end
