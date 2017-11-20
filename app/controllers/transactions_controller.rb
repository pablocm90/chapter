class TransactionsController < ApplicationController

  before_action :set_book


  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new
    params[:episode_id] ?  @transaction.episode = set_episode : @transaction.episode = nil
    @transaction.book = @book
    @transaction.user = current_user
    @transaction.save
    reduce_tokens
    pay_author
    redirect_to book_episode_path(@book,@episode)
  end

  private

  def set_episode #because this param comes from somewhere elese , the url instead of the form
    @episode = Episode.find(params[:episode_id])
  end

  def set_book #because this param comes from somewhere elese , the url instead of the form
    @book = Book.find(params[:book_id])
  end

  def reduce_tokens
    current_user.tokens -= @episode.price
    current_user.save
  end

  def pay_author
    @author = @book.author.user
    @author.tokens += @episode.price
    @author.save
  end


end
