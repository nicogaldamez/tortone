class VehicleDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper

  def identification
    "#{object.brand} #{object.vehicle_model} - #{object.version}"
  end

  def brand_and_model
    "#{object.brand} #{object.vehicle_model}"
  end

  def price
    number_to_currency(object.price, precision: 2) || '-'
  end

  def unformatted_price
    object.price
  end

  def color
    object.color.blank? ? '-' : object.color.titleize
  end

  def is_consignment
    I18n.t(object.is_consignment.to_s)
  end

  def is_financed
    I18n.t(object.is_financed.to_s)
  end

  def is_hdi
    I18n.t(object.is_hdi.to_s)
  end

  def has_automatic_transmission
    I18n.t(object.has_automatic_transmission.to_s)
  end

  def transfer_amount
    object.transfer_amount || 0
  end

  def minimum_advance
    number_to_currency(object.minimum_advance, precision: 2) || '-'
  end

  def unformatted_minimum_advance
    object.minimum_advance
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
    "#{object.year} | #{kilometers} | #{self.color}"
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

  def klass
    object.is_owner ? 'own-vehicle' : 'others-vehicle'
  end

  def customer
    c = object.customer.decorate
    c.full_name
  end

  def sale_situation_text
    if object.sale.sold?
      "Vehículo vendido el #{object.sale.sold_on}. Para ver los detalles de la venta haga click "\
      "#{h.link_to('aquí', object.sale)}".html_safe
    else
      "Vehículo señado. Para ver los detalles de la venta haga click "\
      "#{h.link_to 'aquí', object.sale}".html_safe
    end
  end

  def sale_advance_badge
    if object.sale && !object.sale.sold_on?
      _customer = object.sale.customer
      _url      = "/customers/#{_customer.id}/edit"
      "<span class='label label-warning' style='margin: 0px 4px 0px 4px;'> Señado </span>"\
      "#{h.link_to(h.content_tag(:span, _customer, class: '', style: 'margin: 0px 4px 0px 4px;'), _url, class: 'label label-default')}".html_safe
    end
  end

end
