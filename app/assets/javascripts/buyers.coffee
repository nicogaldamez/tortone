class App.BuyerForm

  constructor: () ->
    @bindEvents()

  # Binding de Eventos
  bindEvents: () ->
    @bindSelects()
    $('#js-buyer-interests').on 'cocoon:after-insert', (e, insertedItem) =>
      @bindSelects(insertedItem)

  bindSelects: (parent) ->
    elements = if (parent) then parent.find("[data-behavior~=searchBrandAndModel]") else $("[data-behavior~=searchBrandAndModel]")
    elements.ajaxSelect()

    $('.js-vehicle-model').on 'select2-selecting', (e)=>
      @onVehicleModelChanged e.target, e.object

  onVehicleModelChanged: (element, vehicle_model) ->
    $(element).parent().find('.js-brand').val vehicle_model.brand_id

# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  buyer_form = new App.BuyerForm() unless $(".buyers.new, .buyers.edit, .buyers.create, .buyers.update").length == 0
