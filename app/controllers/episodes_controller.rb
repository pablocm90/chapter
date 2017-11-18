class EpisodesController < ApplicationController
  RENDER_OPTIONS = {
    escape_html: true,
    hard_wrap: true
  }

  MARKDOWN_OPTIONS = {
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    disable_indented_code_blocks: true,
    autolink: false,
    tables: true,
    underline: true
  }

  before_action :set_book
  before_action :set_episode, except: [:new, :create]
  skip_before_action :authenticate_registration!
  attr_reader :convert_markdown


  # I am not sure this method is really needed?
  # def index
  #   @episodes = Episode.all
  # end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(episode_params)
    @episode.number = (@book.episodes.count == 0) ? 1 : @book.episodes.last.number.to_i + 1
    @episode.book = @book
    if @episode.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def buy
  end

  def show
    @converted = convert_markdown(@episode.content)
    @author = @episode.book.author
    @ndp = @author.nom_de_plume? ? @author.nom_de_plume : @author.user.registration.username
  end



  private

  def convert_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(RENDER_OPTIONS), MARKDOWN_OPTIONS)
    markdown.render(text).html_safe
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:title, :description, :content)
  end



end
