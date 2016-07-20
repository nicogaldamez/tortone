class VehiclesPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def title
    if only_my_cars?
      'Mis Vehículos'
    else
      'Todos los vehículos'
    end
  end

  def vehicles
    @vehicles ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= VehicleFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:vehicle_filter]
      parameters = @params.require(:vehicle_filter).permit(
                                :brand, :vehicle_model, :name, :is_owner)
    end
    parameters || {}
  end

  def only_my_cars?
    return false unless @params[:vehicle_filter]
    @params[:vehicle_filter][:is_owner]
  end

end
