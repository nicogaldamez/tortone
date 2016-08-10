class BrandsController < ApplicationController

  before_action :set_brand, only: [:edit, :update, :destroy]

  # GET /brands
  def index
    @brands = Brand.all
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # POST /brands
  def create
    @brand = Brand.new(brand_params)
    respond_to do |format|
      if @brand.save
        format.json { render json: {result: 'success', data: @brand} }
        format.html { redirect_to brands_path, notice: 'La marca se ha creado correctamente' }
      else
        format.json { render json: {result: 'error', error_messages: @brand.errors, full_error_messages: @brand.errors.full_messages} }
        format.html { render :new }
      end
    end
  end

  # GET /brands/:id/edit
  def edit
  end

  # PUT /brands/:id
  def update
    if @brand.update(brand_params)
      redirect_to brands_path,
        notice: 'La marca ha sido actualizada correctamente.'
    else
      render :edit
    end
  end

  # DELETE /brands/:id
  def destroy
    if @brand.destroy
      redirect_to brands_path,
        notice: 'La marca ha sido eliminada correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar la marca'
      redirect_to brands_path
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end


end
