require 'numero_a_letras'
class SaleCertificate

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
    '<b>CONTRATO DE COMPRA-VENTA </b>'
  end

  def date_and_place
    "<br><br>LUGAR Y FECHA: <b> LA PLATA #{I18n.l(Time.zone.today, format: :long)}</b><br><br>"
  end

  def body
    "EL SR/A <b>TORTONE MATÍAS </b> DNI NRO <b> 29131895 </b> DOMICILIADO EN <b> 35 NRO 566 LA PLATA </b>"\
    "<br><br>VENDE Y CEDE<br><br>"\
    "AL SR/A <b> #{customer.full_name.upcase} </b> DNI <b> #{customer.dni.capitalize} </b> DOMICILIADO EN <b> #{customer.address.capitalize} </b>"\
    "<br><br><br>"\
    "LO SIGUIENTE: <b> UN AUTOMOTOR USADO </b> "\
    "<br><br><br>"\
    "MARCA <b> #{vehicle.brand.name.upcase} </b> "\
    "MODELO <b> #{vehicle.vehicle_model.name.upcase} #{vehicle.version.name.upcase} </b> "\
    "TIPO <b> #{vehicle.vehicle_type.upcase unless vehicle.vehicle_type.nil?}</b><br> "\
    "MOTOR NUMERO <b> #{vehicle.motor_number} </b> "\
    "CHASIS NUMERO <b> #{vehicle.chassis_number}</b><br> "\
    "MODELO AÑO <b> #{vehicle.year} </b> "\
    "DOMINIO <b> #{vehicle.plate.upcase} </b>"\
    "<br>RADICADO EN <b>LA PLATA</b> </b> "\
    "<br><br>"\
    "EN EL BUEN ESTADO DE FUNCIONAMIENTO EN QUE SE ENCUENTRA, QUIEN PREVIA "\
    "INSPECCIÓN DEL COMPRADOR Y DE HABER CONSTATADO LA SITUACIÓN REGISTRAL "\
    "Y FISCAL DEL AUTOMOTOR, EL QUE SE ENCUENTRA LIBRE DE TODO GRAVAMENES Y "\
    "DEUDAS, TOMARA POSESIÓN DEL MISMO, EL DÍA <b> #{Time.zone.today}</b> "\
    "A LAS <b>10:00</b> HS QUIEN A PARTIR DE ESE  MOMENTO SE HARÁ RESPONSABLE "\
    "CIVIL, PENAL Y TRIBUTARIAMENTE.-"\
    "<br><br>"\
    "EL PRECIO DE VENTA SE ESTABLECE EN PESOS ( <b>#{@sale.total_in_letters.upcase}</b> "\
    "INCLUIDO LA TRANSFERENCIA ). EL COMPRADOR ENTREGA EN ESTE ACTO"\
    " LA CANTIDAD DE PESOS <b>#{@sale.remaining_in_letters.upcase}</b> DE CONTADO EFECTIVO,"\
    "<br><br>"\
    "EN PRUEBA DE CONFORMIDAD SE FIRMAN DOS EJEMPLARES DEL MISMO TENOR Y A UN SOLO "\
    "EFECTO EN LA CIUDAD DE <b> LA PLATA </b> A LOS <b>#{Time.zone.today.day}</b> DÍAS DEL "\
    "MES DE <b>#{I18n.l(Time.zone.today, format: :month).upcase}</b> DEL AÑO <b>#{Time.zone.today.year}</b>."
  end

  def footer
    "<div>#{'<br>'*6}"\
      "#{'&nbsp;'*10}FIRMA DEL COMPRADOR #{'&nbsp;'*50} FIRMA VENDEDOR<br>"\
      "#{'&nbsp;'*10}DNI #{'&nbsp;'*93} DNI"\
    "</div>"
  end

end
