class BooksController < ApplicationController
  # The show method displays only further details on a single book
  # Find only the book that has the id defined in params[:id]
  skip_before_action :authenticate_registration!, only: [:index, :show, :search, :filter_genre]
  before_action :set_book, only: [:show, :buy]

  def show
   @user = current_user
   @review = Review.new
  end

 def new
  @author = current_author
  @book = Book.new

 end

 def create
  @book = Book.new(book_params)
  @book.author = current_author
  if @book.save
    redirect_to author_dashboard_path
  else
    render :new
  end
 end

 def search
    # @genres = []
    # @books.each do |book|
    #   @genres << book.genre
    # end
    # @genres.uniq!
    # removed since using Active records might make it quicker

    # @authors = []
    # @books.each do |book|
    #   @authors << book.author.nom_de_plume
    # end
    # @authors.uniq!


    # onder index te plaatsen (english?)
    # Careful cause the end result is not really ordered!

    Book.reindex
    @query = params[:query]
    @books = @query ? Book.search(@query) : Book.all

    @genres = @books.pluck(:genre).uniq

    @authors = @books.map { |book| Author.find(book.author_id).nom_de_plume }.uniq

    sort_results(@books)

    if params[:genre]
      @selected_genre = params[:genre]
      @books = @books.select { |b| b.genre == @selected_genre }
      sort_results(@books)
    end
    if params[:author]
      @selected_author = params[:author]
      @books = @books.select { |b| b.author.nom_de_plume == @selected_author }
      sort_results(@books)
    end
  end

  def index
    @books = Book.all
  end

  def buy
  end


private

  def sort_results(data)
    @ordered_books = data.sort_by { |book| average_rating(book) }
    @ordered_books.reverse!
  end

  def average_rating(book)
    book.reviews.count != 0 ? @average_rating = book.reviews.average(:rating) : @average_rating = 0
  end

  def book_params
    params.require(:book).permit(:title, :description, :genre, :tags, :cover_pic, :cover_pic_cache, :quote_hover)
  end

  def set_book
    @book = Book.find(params[:id])
  end


end
