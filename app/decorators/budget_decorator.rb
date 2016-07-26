class BudgetDecorator < Draper::Decorator
  delegate_all

  def vehicle_description
    if vehicle
      "#{vehicle.brand} #{vehicle.vehicle_model} #{vehicle.version}"
    else
      object.vehicle_description
    end
  end

  def expenses
    object.expenses || '--'
  end

  def financed
    object.financed || 0
  end

  def minimum_advance
    object.minimum_advance || 0
  end

  def notes
    object.notes || '--'
  end


end
