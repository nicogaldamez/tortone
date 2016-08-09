class SalesController < ApplicationController

  before_filter :set_sale, only: [:show, :edit, :update, :destroy,
                                  :pre_print_advance_certificate, :pre_print_sale_certificate]

  # GET /sales
  def index
    @presenter = SalesPresenter.new(params)
  end

  # GET /sales/:id
  def show
    @presenter = SalePresenter.new(@sale)
  end

  # GET /sales/new
  def new
    @sale = new_sale_from_vehicle
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      update_vehicle()
      redirect_to @sale, notice: 'La venta ha sido creada con éxito'
    else
      render :new
    end
  end

  # GET /sales/:id/edit
  def edit
  end

  # PUT /sales/:id
  def update
    if @sale.update(sale_params)
      update_vehicle()
      redirect_to @sale, notice: 'La venta se ha actualizado correctamente'
    else
      @vehicle = @sale.vehicle
      render :edit
    end
  end

  # DELETE /sales/:id
  def destroy
    if @sale.destroy
      @sale.vehicle.update(sold_on: nil)
      CoincidenceFinder.call(vehicle: @sale.vehicle) # Actualizo coincidencias

      redirect_to sales_path,
        notice: 'La venta sido eliminada correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar la venta'
      redirect_to sales_path
    end
  end

  # GET /sales/:id/pre_print_advance_certificate
  def pre_print_advance_certificate
    @content = AdvanceCertificate.new(@sale).content
  end

  # GET /sales/:id/pre_print_sale_certificate
  def pre_print_sale_certificate
    @content = SaleCertificate.new(@sale).content
  end


  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:vehicle_id, :price, :notes, :sold_on,
                                 :advance, :customer_id, :advance_delivered_on)
  end

  def new_sale_from_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id]).decorate
    Sale.new(
      vehicle_id: @vehicle.id,
      price: @vehicle.unformatted_price
    )
  end

  def update_vehicle
    if sale_params[:sold_on].present?
      @sale.vehicle.update(sold_on: sale_params[:sold_on])
      CoincidenceFinder.call(vehicle: @sale.vehicle) # Actualizo coincidencias
    end
  end

end
