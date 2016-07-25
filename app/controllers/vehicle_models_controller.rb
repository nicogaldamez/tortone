class VehicleModelsController < ApplicationController

  # GET /vehicle_models
  def index
    vehicle_models = VehicleModel.all
    vehicle_models = VehicleModel.where(brand_id: params[:brand_id]) if params[:brand_id]

    render json: vehicle_models.as_json
  end

  # POST /vehicle_models
  def create
    @vehicle_model = VehicleModel.new(vehicle_model_params)
    respond_to do |format|
      if @vehicle_model.save
        format.json { render json: {result: 'success', data: @vehicle_model} }
      else
        format.json { render json: {result: 'error', error_messages: @vehicle_model.errors, full_error_messages: @vehicle_model.errors.full_messages} }
      end
    end
  end

  # GET /vehicle_models/search
  def search
    if params[:with_brand]
      scope = :search_in_model_and_brand
      block = ->(vehicle_model) { { id: vehicle_model.id, name: "#{vehicle_model.brand.to_s} #{vehicle_model.to_s}",
                                    brand_id: vehicle_model.brand_id } }
    else
      scope = :search
      block = ->(vehicle_model) { { id: vehicle_model.id, name: vehicle_model.to_s } }
    end

    records = RecordSearcher.new(VehicleModel, params, scope).call(&block)
    render json: records.to_json, callback: params[:callback]
  end

  private

  def vehicle_model_params
    params.require(:vehicle_model).permit(:name, :brand_id)
  end

end
