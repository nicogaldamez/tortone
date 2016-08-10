require 'numero_a_letras'
class AdvanceCertificate

  def initialize(sale)
    @sale = sale.decorate
    @content = ''
  end

  def content
    "#{@content} #{title} #{date_and_place} #{body} #{footer}"
  end

  private

  def vehicle
    @vehicle ||= @sale.vehicle.decorate
  end

  def customer
    @customer ||= @sale.customer.decorate
  end

  def title
    '<b>RECIBO DE SEÑA </b>'
  end

  def date_and_place
    "<br><br>Lugar y Fecha: <b> La Plata #{I18n.l(Time.zone.today, format: :long)}</b><br><br>"
  end

  def body
      "Recibí del señor <b> #{customer.full_name} </b> DNI <b> #{customer.dni} </b> "\
      "la suma de <b> #{@sale.unformatted_advance.a_moneda} </b> en concepto de seña por la venta del automotor, cuyas características "\
      "se detallan más abajo, en las condiciones PERFECTA que se encuentra y libre de todo gravamen."\
      "<br><br>" \
      "Vehículo dominio: <b> #{vehicle.plate} </b> <br>"\
      "Marca: <b> #{vehicle.brand} </b> <br>"\
      "Tipo: <b> #{vehicle.vehicle_model} </b> <br>"\
      "Modelo: <b> #{vehicle.version} </b> <br>"\
      "Motor marca: <b> PEUGEOT </b> <br>"\
      "Número: <b> #{vehicle.motor_number} </b> <br>"\
      "Carrocería-chasis marca: <b> PEUGEOT </b> <br>"\
      "Número: <b> #{vehicle.chassis_number} </b> <br>"\
      "Año de fabricación: <b> #{vehicle.year} </b> <br>"\
      "Color: <b> #{vehicle.color} </b> <br>"\
      "<br>"\
      "Se deja expresa constancia que el \"comprador\" deberá abonar el saldo pendiente de "\
      "<b> #{@sale.remaining.a_moneda} </b> ( INCLUYENDO TRANSFERENCIA) "\
      "dentro de los <b>10</b> días, a contar del día de la fecha, en el domicilio del \"vendedor\"."\
  end

  def footer
    "<div><br><br>"\
      "Teléfono: <b>02216403041 // fijo 02221453551 </b> <br>"\
      "Apellido y Nombre: <b>Matías Tortone </b> <br>"\
      "Domicilio: <b>35 Nro ... </b> <br>"\
      "DNI: <b> ... </b> <br>"\
      "<br><br><br>"\
      "Firma y Aclaración"\
    "</div>"
  end

end
