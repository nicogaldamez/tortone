class App.VehicleForm

  constructor: () ->
    @bindEvents()
    @customerModal = new App.CustomerModalForm('#js-modal', @onCustomerCreated)

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()

  onCustomerCreated: (data) ->
    $('input[data-behavior~=searchCustomer]').select2('data', data)

$(document).on "page:change", ->
  new App.VehicleForm() unless $(".vehicles.new, .vehicles.edit").length == 0
