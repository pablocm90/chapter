class UsersController < ApplicationController
  skip_before_action :authenticate_registration!
  before_action :set_registration
  before_action :set_user


def show
  @user = User.find(83)
  @my_books = []
  @user.transactions.each do |transaction|
    book = transaction.book
    @my_books << book
  end
  @my_books.uniq!

  @my_genres = []
  @my_books.each do |book|
    genre = book.genre
    @my_genres << genre
  end
  @my_genres.uniq!

end


  private

  def set_registration
    @registration = current_registration
  end

  def set_user
    @user = current_user
  end

end
