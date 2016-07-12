class App.VehicleForm

  constructor: () ->
    @bindEvents()
    @customer_modal       = new App.CustomerModalForm('#js-modal', @onCustomerCreated)
    @vehicle_model_select = new App.VehicleModelSelect('#js-vehicle-model')

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()
    $('#js-brand').change (e)=>
      @vehicle_model_select.update($(e.target).val())

  onBrandChanged: ->
    brand_id = $('#js-brand')

  onCustomerCreated: (data) ->
    $('input[data-behavior~=searchCustomer]').select2('data', data)

# ---------------------------------
class App.VehicleModelSelect

  constructor: (element_id) ->
    @element = $(element_id)

  update: (brand_id) ->
    $.ajax
      url: '/vehicle_models.json'
      data:
        brand_id: brand_id
      success: (data) =>
        @element.empty()
        data = [{'id':'1','text': 'asdf'}]
        @element.select2 'data', data




# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.VehicleForm() unless $(".vehicles.new, .vehicles.edit").length == 0
