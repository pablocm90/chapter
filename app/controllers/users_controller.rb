class UsersController < ApplicationController

  before_action :set_registration
  before_action :set_user

def show

end


  private

  def set_registration
    @registration = current_registration
  end

  def set_user
    @user = current_user
  end

end
