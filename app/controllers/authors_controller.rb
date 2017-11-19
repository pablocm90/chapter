class AuthorsController < ApplicationController
  skip_before_action :authenticate_registration!
  before_action :set_author, only: [:show, :dashboard]

# GET
def new
  @author = Author.new
end

# POST
def create
  @author = Author.new(author_params)
  @author.user = current_user
  if @author.save
      user_author
      redirect_to author_dashboard_path(current_author)
    else
     render :new
   end
 end

def show
end

def dashboard
  @books = current_author.books
  @my_transactions = current_author.transactions.
end

private

def author_params
  params.require(:author).permit(:nom_de_plume, :bank_account, :status, :user_id)
end

def set_author
  @author = params[:id] ? Author.find(params[:id]) : current_author
end

def user_author
  current_user.is_author = true
  current_user.save
end


end
