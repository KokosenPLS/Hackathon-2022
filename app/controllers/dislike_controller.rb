class DislikeController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    @dislike = product.dislikes.build
    @dislike.user = current_user
    @dislike.save
  end


end
