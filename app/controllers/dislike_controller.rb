class DislikeController < ApplicationController

  def create
    rental = Rental.find(params[:rental_id])
    @dislike = rental.dislikes.build
    @dislike.user = current_user
    @dislike.save
  end


end
