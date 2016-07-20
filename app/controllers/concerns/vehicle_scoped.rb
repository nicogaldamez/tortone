module VehicleScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_vehicle
  end

  private
    def set_vehicle
      if params[:vehicle_id]
        @vehicle = Vehicle.find(params[:vehicle_id])
      end
    end
end
