class UsersController < ApplicationController
  skip_before_action :authenticate_registration!
  before_action :set_registration
  before_action :set_user


def show
  @user = User.find(1)
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

def edit

end

def update
    @user.update(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'show'
    end
end




  private

  def set_registration
    @registration = current_registration
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:picture, :picture_cache, :description,:registration_id, :fav_genre, :f_name, :l_name, :tokens, :active)
  end

end
