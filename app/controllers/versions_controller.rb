class VersionsController < ApplicationController

  def index
    versions = Version.all
    versions = Version.where(vehicle_model_id: params[:vehicle_model_id]) if params[:vehicle_model_id]

    render json: versions.as_json
  end

end
