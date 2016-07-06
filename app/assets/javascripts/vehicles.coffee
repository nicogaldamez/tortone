class App.VehicleForm

  constructor: () ->
    @bindEvents()

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()

$(document).on "page:change", ->
  new App.VehicleForm() unless $(".vehicles.new, .vehicles.edit").length == 0
