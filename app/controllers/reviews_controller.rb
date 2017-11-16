class ReviewsController < ApplicationController
  skip_before_action :authenticate_registration!, except: [:create]

  def index
    @book = set_book
    @reviews = Review.all
  end

  def new
    @book = set_book
    @review = Review.new
  end

  def create
    @book = set_book
    user = current_user
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = user
    if @review.save!
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def test
    @book = set_book
    @reviews = Review.all

  end


  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_book #because this param comes from somewhere elese , the url instead of the form
    @book = Book.find(params[:book_id])
  end
end

