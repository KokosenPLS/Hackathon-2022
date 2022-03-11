class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_product, except: [:index, :create]


  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @product.comments.build
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("btn_add_comment", partial: "comments/form", locals: {comment: @comment})
        ]
      end
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    logger.debug "Logg"
    @comment = current_user.comments.new(comment_params)


    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("btn_add_comment", partial: "comments/new_comment_btn", locals:{ product: @comment.product }),
            turbo_stream.prepend("comments", @comment, locals:{ comment: @comment})
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :product_id)
    end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
