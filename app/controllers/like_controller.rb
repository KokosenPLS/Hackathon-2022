class LikeController < ApplicationController
  before_action :authenticate_user!


  def create
    product = Product.find(params[:product_id])
    @like = product.likes.build
    @like.user = current_user
    @like.save
  end

end
