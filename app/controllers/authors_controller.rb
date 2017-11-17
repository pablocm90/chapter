class AuthorsController < ApplicationController
  skip_before_action :authenticate_registration!

# GET
def new
  @author = Author.new
end

# POST
def create
  @author = Author.new(author_params)
  @author.user = current_user
  current_user.is_author = true
  if @author.save
      # We need to update the redirect_to path
      current_user.save
      redirect_to author_dashboard_path(current_author)
    else
     render :new
   end
 end

 def show
  if params[:id]
    @author = Author.find(params[:id])
  else
    @author = current_author
  end
end

def dashboard
  @books = current_author.books

end

private

def author_params
  params.require(:author).permit(:nom_de_plume, :bank_account, :status, :user_id)
end

end
