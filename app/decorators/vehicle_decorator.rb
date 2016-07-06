class VehicleDecorator < Draper::Decorator
  delegate_all

  def identification
    "#{object.brand} #{object.vehicle_model}"
  end

end
