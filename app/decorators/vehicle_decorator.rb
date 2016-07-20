class VehicleDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def identification
    "#{object.brand} #{object.vehicle_model} - #{object.version}"
  end

  def brand_and_model
    "#{object.brand} #{object.vehicle_model}"
  end

  def price_label
    object.is_owner ? "Precio" : "Monto pretendido por el dueño"
  end

  def price
    number_to_currency(object.price, precision: 2) || '-'
  end

  def is_exchange
    I18n.t(object.is_exchange.to_s)
  end

  def is_consignment
    I18n.t(object.is_consignment.to_s)
  end
  
  def is_financed
    I18n.t(object.is_financed.to_s)
  end
  
  def transfer_amount
    object.transfer_amount || '-'
  end
  
  def minimum_advance
    number_to_currency(object.minimum_advance, precision: 2) || '-'
  end
  
  def sold_on
    object.sold_on || '-'
  end
  
  def details
    object.details.blank? ? '-' : object.details
  end
  
  def kilometers
    "#{object.kilometers} km"
  end

  def specs
    "#{object.year} | #{kilometers} | #{object.color}"
  end
  
  def plate
    object.plate.present? ? object.plate.upcase : '-'
  end
  
  def motor_number
    object.motor_number.present? ? object.motor_number : '-'
  end
  
  def chassis_number
    object.chassis_number.present? ? object.chassis_number : '-'
  end

  # TODO: add a class for owned vehicles
  def klass
    object.is_owner ? 'some_class' : ''
  end

  def customer
    c = object.customer.decorate
    c.full_name
  end

end
