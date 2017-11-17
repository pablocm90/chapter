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
    redirect_to root_path
  else
    render :new
  end
end

def dashboard

end


private

def author_params
  params.require(:author).permit(:nom_de_plume, :bank_account, :status, :user_id)
end

end
