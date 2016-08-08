class VehiclesController < ApplicationController

  before_filter :set_vehicle, only: [:edit, :update, :destroy, :prepare_to_publish, :publish]

  def index
    @presenter = VehiclesPresenter.new(params)
  end

  def show
    @vehicle = Vehicle.find(params[:id]).decorate

    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'El vehículo buscado no existe'
      redirect_to vehicles_path
  end

  def new
    @vehicle = Vehicle.new(vehicle_params)
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      CoincidenceFinder.call(vehicle: @vehicle)
      
      redirect_to @vehicle,
        notice: 'El vehículo ha sido creado correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vehicle.update(vehicle_params)
      CoincidenceFinder.call(vehicle: @vehicle)
      
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
  
  def prepare_to_publish
    respond_to do |format|
      format.js
    end
  end
  
  def publish
    response = FacebookPublisher.new(@vehicle.decorate).post
    
    if response[:status] == :ok
      flash[:success] = 'El vehículo se ha publicado en Facebook exitosamente'
    else
      flash[:error] = 'Ocurrió un error al intentar conectarse con Facebook'
    end
    
    redirect_to @vehicle
  end


  private

  def vehicle_params
    params.require(:vehicle).permit(:kilometers, :color, :details, :cost,
            :price, :entered_on, :sold_on, :is_exchange, :is_consignment,
            :is_financed, :minimum_advance, :transfer_amount, :plate,
            :year, :motor_number, :chassis_number, :vehicle_model_id,
            :is_hdi, :has_automatic_transmission,
            :version_id, :brand_id, :customer_id, :is_owner) if params[:vehicle].present?
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

end
