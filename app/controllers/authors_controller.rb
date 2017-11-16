class AuthorsController < ApplicationController

# GET
def new
  @author = Author.new
end

# POST
def create
  @author = Author.new(author_params)
  @author.user = current_user
  if @author.save
    # We need to update this!!
    redirect_to author_books_path
  else
    render :new
  end
end

private

def author_params
  params.require(:author).permit(:nom_de_plume, :bank_account, :status, :user_id)
end

end
