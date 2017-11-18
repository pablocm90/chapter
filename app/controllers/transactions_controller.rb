class TransactionsController < ApplicationController

  before_action :set_book


  def new
    @transaction = Transaction.new
  end

  def create
    @user = current_user
    @transaction = Transaction.new
    params[:episode_id] ?  @transaction.episode = set_episode : @transaction.episode = nil
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
