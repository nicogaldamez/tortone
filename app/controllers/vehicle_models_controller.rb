class VehicleModelsController < ApplicationController

  before_action :set_vehicle_model, only: [:edit, :update, :destroy]

  # GET /vehicle_models
  def index
    @vehicle_models = VehicleModel.all
    @vehicle_models = @vehicle_models.where(brand_id: params[:brand_id]) if params[:brand_id]
    @vehicle_models = @vehicle_models.includes(:brand)

    respond_to do |format|
      format.json { render json: @vehicle_models.as_json }
      format.html
    end
  end

  # GET /vehicle_models/new
  def new
    @modal_form = params[:modal] || false
    @vehicle_model = VehicleModel.new
    if @modal_form
      render :new, layout: nil
    else
      render :new
    end
  end

  # POST /vehicle_models
  def create
    @vehicle_model = VehicleModel.new(vehicle_model_params)
    respond_to do |format|
      if @vehicle_model.save
        format.json { render json: {result: 'success', data: @vehicle_model} }
        format.html { redirect_to vehicle_models_path, notice: 'El modelo se ha creado correctamente' }
        format.js
      else
        format.json { render json: {result: 'error', error_messages: @vehicle_model.errors, full_error_messages: @vehicle_model.errors.full_messages} }
        format.html { render :new }
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

  # GET /vehicle_models/:id/edit
  def edit
  end

  # PUT /vehicle_models/:id
  def update
    if @vehicle_model.update(vehicle_model_params)
      redirect_to vehicle_models_path,
        notice: 'El modelo ha sido actualizado correctamente.'
    else
      render :edit
    end
  end

  # DELETE /vehicle_models/:id
  def destroy
    if @vehicle_model.destroy
      redirect_to vehicle_models_path,
        notice: 'El modelo ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el modelo'
      redirect_to vehicle_models_path
    end
  end

  private

  def vehicle_model_params
    params.require(:vehicle_model).permit(:name, :brand_id)
  end

  def set_vehicle_model
    @vehicle_model = VehicleModel.find(params[:id])
  end

end
