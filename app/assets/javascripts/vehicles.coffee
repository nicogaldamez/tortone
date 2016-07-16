class App.VehicleForm

  constructor: () ->
    @bindEvents()
    @customer_modal       = new App.CustomerModalForm('#js-modal', @onCustomerCreated)
    @vehicle_model_select = new App.VehicleModelSelect('#js-vehicle-model')
    @version_select       = new App.VersionSelect('#js-version')

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()

    $('#js-brand').change (e)=>
      @onBrandChanged $(e.target).val()

    $('#js-vehicle-model').change (e)=>
      @onVehicleModelChanged $(e.target).val()

    $('#js-version').change (e)=>
      @onVersionChanged $(e.target).val()


  onBrandChanged: (brand_id)->
    @vehicle_model_select.update(brand_id)
    $('#js-vehicle-model').val('')

  onVehicleModelChanged: (model_id)->
    data = $('#js-vehicle-model').select2('data')
    text = if data then data.text else ''

    isNew = text.match(/.*\(Nuevo\)/)
    if isNew
      @createVehicleModel(model_id)

    @version_select.update(model_id)
    $('#js-version').val('')

  onVersionChanged: (version_id)->
    data = $('#js-version').select2('data')
    text = if data then data.text else ''

    isNew = text.match(/.*\(Nuevo\)/)
    if isNew
      @createVersion(version_id)

  onCustomerCreated: (data) ->
    $('input[data-behavior~=searchCustomer]').select2('data', data)

  createVehicleModel: (name)->
    $.ajax
      url: '/vehicle_models'
      method: 'post'
      data:
        vehicle_model:
          brand_id: $('#js-brand').val()
          name: name
      success: (data) =>
        @vehicle_model_select.update(
          $('#js-brand').val()
          data.data.id
        )

  createVersion: (name)->
    $.ajax
      url: '/versions'
      method: 'post'
      data:
        version:
          vehicle_model_id: $('#js-vehicle-model').val()
          name: name
      success: (data) =>
        @version_select.update(
          $('#js-vehicle-model').val()
          data.data.id
        )

# ---------------------------------
class App.VehicleModelSelect

  constructor: (element_id) ->
    $('#js-vehicle-model').normalSelect @options_with_data()
    @element = $(element_id)
    if $('#js-brand').val()
      @update($('#js-brand').val())

  options_with_data: (data=[]) ->
    data: data
    placeholder: 'Buscar Versión...'
    createSearchChoice: (term)->
      id: term
      text: "#{term} (Nuevo)"

  update: (brand_id, option_selected) ->
    $.ajax
      url: '/vehicle_models.json'
      data:
        brand_id: brand_id
      success: (data) =>
        vehicle_models = data.map (vehicle_model)-> { id: vehicle_model['id'], text: vehicle_model['name'] }
        @element.normalSelect @options_with_data(vehicle_models)
        if option_selected
          @element.select2('val', option_selected)
        else
          @element.trigger('change')


# ---------------------------------
class App.VersionSelect

  constructor: (element_id) ->
    $('#js-version').normalSelect({data:[]})
    @element = $(element_id)
    if $('#js-vehicle-model').val()
      @update($('#js-vehicle-model').val(), @element.val())

  options_with_data: (data=[]) ->
      data: data
      placeholder: 'Buscar Modelo...'
      createSearchChoice: (term)->
        id: term
        text: "#{term} (Nuevo)"

  update: (vehicle_model_id, option_selected) ->
    $.ajax
      url: '/versions.json'
      data:
        vehicle_model_id: vehicle_model_id
      success: (data) =>
        versions = data.map (version)-> { id: version['id'], text: version['name'] }
        @element.normalSelect @options_with_data(versions)
        if option_selected
          @element.select2('val', option_selected)
        else
          @element.trigger('change')




# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.VehicleForm() unless $(".vehicles.new, .vehicles.edit").length == 0
