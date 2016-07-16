class VersionsController < ApplicationController

  def index
    versions = Version.all
    versions = Version.where(vehicle_model_id: params[:vehicle_model_id]) if params[:vehicle_model_id]

    render json: versions.as_json
  end

  # POST /versions
  def create
    @version = Version.new(version_params)
    respond_to do |format|
      if @version.save
        format.json { render json: {result: 'success', data: @version} }
      else
        format.json { render json: {result: 'error', error_messages: @version.errors, full_error_messages: @version.errors.full_messages} }
      end
    end
  end

  private

  def version_params
    params.require(:version).permit(:name, :vehicle_model_id)
  end

end
