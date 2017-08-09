require 'numero_a_letras'
class SaleDecorator < Draper::Decorator
  delegate_all

  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TextHelper

  def brand_and_model
    vehicle_decorated.brand_and_model
  end

  def version
    vehicle_decorated.version
  end

  def specs
    vehicle_decorated.specs
  end

  def price
    h.best_in_place object, :price, display_with: :number_to_currency
  end

  def klass
    vehicle_decorated.klass
  end

  def expenses
    h.best_in_place object, :expenses, display_with: :number_to_currency
  end

  def transfer_amount
    h.best_in_place object, :transfer_amount, display_with: :number_to_currency, title: "El valor ingresado se comparará con el costo de transferencia que se había cargado en el vehículo, y se usará para determinar si hubo ganancias o pérdidas asociadas al pago de la transferencia"
  end

  def cash
    number_to_currency(object.cash, precision: 2) || '-'
  end

  def profit
    number_to_currency(unformatted_profit)
  end

  def vehicle_cost
    h.best_in_place object.vehicle, :cost, display_with: :number_to_currency
  end

  def unformatted_profit
    object.price - object.expenses - (vehicle_decorated.cost || 0) + unformatted_transfer_difference
  end

  def unformatted_transfer_difference
    (vehicle_decorated.transfer_amount || 0) - (object.transfer_amount || 0)
  end

  def unformatted_vehicle_cost
    vehicle_decorated.cost || 0
  end

  def unformatted_expenses
    object.expenses || 0
  end

  def price_in_letters
    object.price.a_moneda
  end

  def advance
    number_to_currency(object.advance, precision: 2) || '-'
  end

  def advance_in_letters
    object.advance.a_moneda
  end

  def unformatted_advance
    object.advance
  end

  def total
    total = object.price
    total += object.vehicle.transfer_amount unless object.vehicle.transfer_amount.nil?
    total
  end

  def total_in_letters
    total.a_moneda
  end

  def remaining
    object.advance.nil? ? total : total - object.advance
  end

  def remaining_in_letters
    remaining.a_moneda
  end

  def notes
    if object.notes.nil? || object.notes.blank?
      '<i> Sin notas </i>'.html_safe
    else
      simple_format(object.notes)
    end
  end

  def sold_on
    object.sold_on || '-'
  end

  def sale_situation
    if object.sold?
      "Vehículo vendido el <b>#{sold_on}</b>".html_safe
    else
      "Vehículo señado con <b> #{advance} </b> el <b> #{object.advance_delivered_on} </b>. "\
      "<br>Resta pagar <b> #{h.number_to_currency(remaining)} </b>".html_safe
    end
  end

  def delete_btn
    if object.sold?
      "#{h.link_to h.content_tag(:strong, 'Eliminar la Venta'), object, method: :delete, data: { confirm: 'Está a punto de eliminar una venta que estaba finalizada. Esto no eliminará el vehículo, pero sí el detalle de la venta. ¿Está seguro?' }, class: 'btn btn-danger btn-block'}".html_safe
    else
      "#{h.link_to h.content_tag(:strong, 'Eliminar la Venta (sólo fue señada)'), object, method: :delete, data: { confirm: 'Está a punto de eliminar una venta que estaba señada (no finalizada). Esto no eliminará el vehículo, pero sí el detalle de la seña. ¿Está seguro?' }, class: 'btn btn-danger btn-block'}".html_safe
    end
  end

  def customer_btn
    _customer = object.customer
    _url      = "/customers/#{_customer.id}/edit"
    "#{h.link_to(h.fa_icon(:user), _url, title: _customer.decorate.full_name, class: 'btn btn-xs btn-info')}".html_safe
  end


  private

  def vehicle_decorated
    @vehicle ||= object.vehicle.decorate
  end
end
