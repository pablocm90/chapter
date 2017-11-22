class BooksController < ApplicationController
  # The show method displays only further details on a single book
  # Find only the book that has the id defined in params[:id]
  skip_before_action :authenticate_registration!, only: [:index, :show, :search, :filter_genre]
  before_action :set_book, except: [:new, :create, :search]
  skip_after_action :verify_authorized, only: :show

  def show
    session[:referal_url] = @book.id unless current_user

    @remaining_price = current_user.not_owned_episodes(@book).pluck(:price).inject(:+) unless current_user.nil?
    @author = @book.author.user
    @review = Review.new
    @episodes = @book.episodes.order(:number).reverse
  end

 def new
  @book = Book.new
  @book.author = current_author
  authorize @book
 end

 def create
  @book = Book.new(book_params)
  @book.author = current_author

  authorize @book
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
    authorize @book
    send_data convert_epub(true), filename: "#{@book.title}.epub"
  end

  def download_book
    authorize @book
    send_data convert_epub(false), filename: "#{@book.title}.epub"
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
      current_user.not_owned_episodes(@book).each do |episode|
        Transaction.create(user: current_user, episode: episode, book: @book)
      end
    else
      episodes = current_user.owned_episodes(@book)
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
