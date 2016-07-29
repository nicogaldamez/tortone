class SalesController < ApplicationController

  # GET /sales
  def index
    @presenter = SalesPresenter.new(params)
  end

  # GET /sales/new
  def new
    @sale = new_sale_from_vehicle
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      redirect_to sales_path, notice: 'La venta ha sido creada con éxito'
    else
      render :new
    end
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:vehicle_id, :price, :notes, :sold_on,
                                 :advance, :customer_id)
  end

  def new_sale_from_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id]).decorate
    Sale.new(
      vehicle_id: @vehicle.id,
      price: @vehicle.unformatted_price
    )
  end

end
