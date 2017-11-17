class TransactionsController < ApplicationController


  def new
    @episode = episode
    @transaction = Transaction.new
  end

  def create
    set_episode
    set_book
    @user = current_user
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

  def set_episode #because this param comes from somewhere elese , the url instead of the form
    @episode = Episode.find(params[:episode_id])
  end

  def set_book #because this param comes from somewhere elese , the url instead of the form
    @book = Book.find(params[:book_id])
  end
end
