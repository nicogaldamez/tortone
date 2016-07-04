class VehicleDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.brand} #{object.model}"
  end

end
