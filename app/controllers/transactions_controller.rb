class TransactionsController < ApplicationController

  skip_before_action :authenticate_registration!

  def new
    @episode = episode
    @transaction = Transaction.new
  end

  def create
    @episode = episode
    @book = @episode.book
    @user = User.first
    @transaction = Transaction.new
    @transaction.episode = @episode
    @transaction.book = @book
    @transaction.user = @user
    if @transaction.save!
      redirect_to book_episode_path(@book,@episode)
    else
      render :new
    end
  end

  private


end
