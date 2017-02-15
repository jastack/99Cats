class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_requests = CatRentalRequest.all
    render :index
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  # def edit
  #   @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
  #   render :edit
  # end
  #
  # def update
  #   @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
  #
  #   if @cat_rental_request.update
  #     redirect_to cat_rental_request_url(@cat_rental_request)
  #   else
  #     render :edit
  #   end
  # end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      flash[:notice] = "Created #{@cat_rental_request.cat_id}"
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      render json: @cat_rental_request.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @cat_rental_requests = CatRentalRequest.all
    @sorted = @cat_rental_requests.to_a.sort{ |el1, el2| el1.start_date <=> el2.start_date}
    render json: @sorted
  end

  def age
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat_rental_request.age
  end

  private
  def cat_rental_request_params
    params[:cat_rental_request].permit(:cat_id, :start_date, :end_date, :status)
  end

end
