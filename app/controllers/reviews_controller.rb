class ReviewsController < ApplicationController
  skip_before_action :authenticate_registration!, except: [:create]
  before_action :set_book

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create

    @review = Review.new(review_params)
    @review.book = @book
    @review.user = current_user
    authorize @review

    if @review.save!
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def test
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

