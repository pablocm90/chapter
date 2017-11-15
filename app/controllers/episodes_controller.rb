class EpisodesController < ApplicationController
  before_action :set_book
  before_action :set_episode, except: [:new, :create]

  def index
    @episodes = Episode.all
  end

  def new
    @episode = Episode.new
  end

  def create
  end

  def buy
  end

  def show
  end



  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:title, :description, :content, :content_pdf, :content_pdf_cache, :content_epub, :content_epub_cache)
  end


end
