class App.VehicleModelForm

  constructor: () ->
    element = $("[data-behavior~=searchBrand]")
    element.normalSelect
      data: element.data('data')
      placeholder: 'Buscar Marca...'
#
# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.VehicleModelForm() unless $(".vehicle_models.new, .vehicle_models.edit, .vehicle_models.create, .vehicle_models.update").length == 0
