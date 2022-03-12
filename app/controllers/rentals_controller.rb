class RentalsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_rental, only: %i[ show edit update destroy set_done ]

  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1 or /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    product = Product.find(params[:product_id])
    @rental = product.rentals.new
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals or /rentals.json
  def create
    @rental = current_user.rentals.new(rental_params)

    if @rental.start_date == Date.current
      Rails.logger.debug "Today!! Set to active"
      @rental.active!
    end

    respond_to do |format|
      if @rental.save
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully created." }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully updated." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy

    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "Rental was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_done
    @rental.done!
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@rental),
          turbo_stream.prepend("done-rentals", @rental),
          turbo_stream.update("active-count", partial:"rentals/active_rentals_counter", locals:{active: @rental.user.rentals.where(status: :active)}),
          turbo_stream.update("done-count", partial:"rentals/done_rentals_counter", locals:{done: @rental.user.rentals.where(status: :done)}),
          turbo_stream.update("modal-body", partial: "rentals/rate_rental", locals:{rental: @rental})
        ]
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_params
      params.require(:rental).permit(:user_id, :product_id, :start_date, :end_date)
    end
end
