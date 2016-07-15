class VehiclesController < ApplicationController

  before_filter :set_vehicle, only: [:edit, :update, :destroy]

  def index
    @presenter = VehiclesPresenter.new(params)
  end
  
  def show
    @vehicle = Vehicle.find(params[:id]).decorate

    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'El vehículo buscado no existe'
      render :index
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to vehicles_path,
        notice: 'El vehículo ha sido creado correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to vehicles_path,
        notice: 'El vehículo ha sido actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    if @vehicle.destroy
      redirect_to vehicles_path,
        notice: 'El vehículo ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el vehículo'
      redirect_to vehicles_path
    end
  end


  private

  def vehicle_params
    params.require(:vehicle).permit(:kilometers, :color, :details, :cost,
            :price, :entered_on, :sold_on, :is_exchange, :is_consignment,
            :is_financed, :minimum_advance, :transfer_amount, :plate,
            :year, :motor_number, :chassis_number, :vehicle_model_id,
            :version_id, :brand_id, :customer_id)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

end
