class LikeController < ApplicationController
  before_action :authenticate_user!


  def create
    rental = Rental.find(params[:rental_id])
    @like = rental.likes.build
    @like.user = current_user
    @like.save
  end

end
