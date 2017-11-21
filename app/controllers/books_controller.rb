class BooksController < ApplicationController
  # The show method displays only further details on a single book
  # Find only the book that has the id defined in params[:id]
  skip_before_action :authenticate_registration!, only: [:index, :show, :search, :filter_genre]
  before_action :set_book, except: [:new, :create, :search]

  def show
    session[:referal_url] = @book.id unless current_user
    @owned_episodes_price = current_user.episodes.select { |e| e.book_id == @book.id }.pluck(:price).reduce(&:+)
    if @owned_episodes_price.nil?
      @remaining_price = @book.episodes.pluck(:price).inject(:+)
    else
      @remaining_price = @book.episodes.pluck(:price).inject(:+) - @owned_episodes_price
    end

    @author = @book.author.user
    @review = Review.new
    @episodes = @book.episodes.order(:number).reverse
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
    Book.reindex
  else
    render :new
  end
 end

 def search
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

  def download_owned_book
    send_data convert_epub(true), filename: "#{@book.title}.epub"
  end

  def download_book
    send_data convert_epub(true), filename: "#{@book.title}.epub"
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

  def convert_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(EpisodesController::RENDER_OPTIONS), EpisodesController::MARKDOWN_OPTIONS)
    markdown.render(text).html_safe
  end

  def convert_epub(owned)
    if owned = true
      episodes = @book.episodes
    else
      episodes = @book.episodes.where (episode.transaction.user_id = current_user.id)
    end

    author = @book.author.nom_de_plume
    content = "# #{@book.title}  \n#{author} "
    episodes.each do |episode|
      content += "  \n#{set_content(episode)}"
    end

    string = convert_markdown(content)

    puts string
    PandocRuby.convert(string, :s, {f: :html, t: :epub }, :table_of_contents)
    # PandocRuby.new(string).to_epub(:table_of_content, :standalone)
  end

  def set_content(episode)
    "## #{episode.title}  \n#{episode.content}"
  end


end
