class VehicleModelsController < ApplicationController

  def index
    vehicle_models = VehicleModel.all
    vehicle_models = VehicleModel.where(brand_id: params[:brand_id]) if params[:brand_id]

    render json: vehicle_models.as_json
  end

end
