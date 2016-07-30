class CoincidencesController < ApplicationController

  before_filter :set_coincidence, only: [:update, :destroy]

  # GET /coincidences
  def index
    @coincidences = Coincidences.all
  end

  # POST /coincidences
  def create
    @coincidence = Coincidence.new(coincidence_params)
    if @coincidence.save
      render :nothing
    else
      flash[:error] = 'Falló el chequeo de coincidencias entre interesados y vehículos'
      redirect_to root_path
    end
  end

  # PUT /coincidences/:id
  def update
    if @coincidence.update(coincidence_params)
      redirect_to coincidences_path
    end
  end

  # DELETE /coincidences/:id
  def destroy
    if @coincidence.destroy
      redirect_to coincidences_path
    else
      flash[:error] = 'Ocurrió un error al eliminar la coincidencia'
      redirect_to coincidences_path
    end
  end


  private

  def coincidence_params
    params.require(:coincidence).permit(:buyer_id, :vehicle_model_id, :brand_id,
                                         :is_ignored)
  end

  def set_coincidence
    @coincidence = Coincidence.find(params[:id])
  end

end
