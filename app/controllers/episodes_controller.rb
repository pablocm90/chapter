class EpisodesController < ApplicationController

  def index
    @episodes = Episode.all
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end


end
