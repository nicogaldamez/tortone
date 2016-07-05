class VehicleDecorator < Draper::Decorator
  delegate_all
  
  include ActionView::Helpers::NumberHelper

  def identification
    "#{object.brand} #{object.vehicle_model} #{object.version}"
  end
  
  def price
    number_to_currency(object.price, precision: 2)
  end
  
  def is_exchange
    object.is_exchange.to_s
  end
  
  def is_consignment
    object.is_consignment.to_s
  end
  
  def customer
    c = object.customer.decorate
    c.full_name
  end

end
