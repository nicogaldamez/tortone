class App.VehicleForm

  constructor: () ->
    @bindEvents()
    @customer_modal       = new App.CustomerModalForm('#js-modal', @onCustomerCreated)
    @vehicle_model_select = new App.VehicleModelSelect('#js-vehicle-model')
    @version_select       = new App.VersionSelect('#js-version')

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()
    $('#js-vehicle-model').normalSelect({data:[]})
    $('#js-version').normalSelect({data:[]})
    $('#js-brand').change (e)=>
      @vehicle_model_select.update($(e.target).val())
      $('#js-vehicle-model').val('')
    $('#js-vehicle-model').change (e)=>
      @version_select.update($(e.target).val())
      $('#js-version').val('')

  onBrandChanged: ->
    brand_id = $('#js-brand')

  onCustomerCreated: (data) ->
    $('input[data-behavior~=searchCustomer]').select2('data', data)

# ---------------------------------
class App.VehicleModelSelect

  constructor: (element_id) ->
    @element = $(element_id)
    if $('#js-brand').val()
      @update($('#js-brand').val())

  update: (brand_id) ->
    $.ajax
      url: '/vehicle_models.json'
      data:
        brand_id: brand_id
      success: (data) =>
        select_data = data.map (vehicle_model)-> { id: vehicle_model['id'], text: vehicle_model['name'] }
        @element.normalSelect { 'data': select_data }
        @element.trigger('change')


# ---------------------------------
class App.VersionSelect

  constructor: (element_id) ->
    @element = $(element_id)
    if $('#js-vehicle-model').val()
      @update($('#js-vehicle-model').val())

  update: (vehicle_model_id) ->
    $.ajax
      url: '/versions.json'
      data:
        vehicle_model_id: vehicle_model_id
      success: (data) =>
        select_data = data.map (version)-> { id: version['id'], text: version['name'] }
        @element.normalSelect { 'data': select_data }




# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.VehicleForm() unless $(".vehicles.new, .vehicles.edit").length == 0
