class UsersController < ApplicationController
  skip_before_action :authenticate_registration!
  before_action :set_registration
  before_action :set_user

def show
  @user = User.find(81)
  @transactions = @user.transactions
end


  private

  def set_registration
    @registration = current_registration
  end

  def set_user
    @user = current_user
  end

end
