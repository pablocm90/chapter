class EpisodesController < ApplicationController
  before_action :set_book

  def index
    @episodes = Episode.all
  end

  def buy
  end


  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_episode
    @episode = Episode.find(params[:id])
  end


end
