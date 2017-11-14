class UsersController < ApplicationController

def show
  @user = current_regitration.user

end


end
