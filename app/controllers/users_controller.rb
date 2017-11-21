class UsersController < ApplicationController
  skip_before_action :authenticate_registration!
  # before_action :set_registration
  # before_action :set_user
  # I don't think we need the before action

  skip_after_action :verify_authorized, only: [:show, :edit, :update]

def show

  @my_books = []
  @my_episodes = []
  @my_genres = []



  unless current_user.transactions.empty?

    transactions = current_user.transactions

    @my_books = transactions.map {|t| Book.find(t.book_id) }.uniq

    @my_episodes = @my_books.pluck(:episode).uniq

    @my_genres = @my_books.map { |book| book.genre }.uniq
  end
end



def edit

end

def update
    current_user.update(user_params)
    if current_user.save
      redirect_to users_path
    else
      render 'show'
    end
end




private

  # from show
  # @user.transactions.each do |transaction|
  #   book = transaction.book
  #   @my_books << book
  # end
  #   @my_genres = []
  #   @my_books.each do |book|
  #     genre = book.genre
  #     @my_genres << genre
  #   end
  #   @my_genres.uniq!
  # end

  # def set_registration
  #   @registration = current_registration
  # end

  # def set_user
  #   @user = current_user
  # end

  def user_params
    params.require(:user).permit(:picture, :picture_cache, :description,:registration_id, :fav_genre, :f_name, :l_name, :tokens, :active)
  end

end
