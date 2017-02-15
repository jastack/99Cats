class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      flash[:notice] = "Created #{@cat.name}"
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: :unprocessable_entity
    end
  end

  # def show
  #   @cat = Cat.find_by(id: params[:id])
  #   render :table
  # end

  def show
    @cat = Cat.find_by(id: params[:id])
    @cat_rental_requests = CatRentalRequest.all
    render :show
  end

  def age
    @cat = Cat.find_by(id: params[:id])
    @cat.age
  end

  private
  def cat_params
    params[:cat].permit(:name, :color, :sex, :birth_date, :description)
  end

end
