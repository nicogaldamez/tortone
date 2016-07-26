class BudgetDecorator < Draper::Decorator
  delegate_all

  def vehicle_description
    if vehicle
      "#{vehicle.brand} #{vehicle.vehicle_model} #{vehicle.version}"
    else
      object.vehicle_description
    end
  end


end
