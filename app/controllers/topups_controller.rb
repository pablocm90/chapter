class TopupsController < ApplicationController
  skip_before_action :authenticate_registration!


  def index
    @topups = Topup.all
    authorize @topups
  end
end
