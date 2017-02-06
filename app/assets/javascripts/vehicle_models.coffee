class App.VehicleModelForm

  constructor: () ->
    @brand_select = new App.BrandSelect('#js-brand')
    @bindEvents()

  bindEvents: () ->
    $('#js-brand').on 'select2-selecting', (e)=>
      @onBrandChanged e.object

  onBrandChanged: (brand)->
    if brand.isNew
      @createBrand(brand.name)

  createBrand: (name)->
    $.ajax
      url: '/brands'
      method: 'post'
      data:
        brand:
          name: name
      success: (data) =>
        @brand_select.update data.data.id, name
#
# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.VehicleModelForm() unless $(".vehicle_models.new, .vehicle_models.edit, .vehicle_models.create, .vehicle_models.update").length == 0
