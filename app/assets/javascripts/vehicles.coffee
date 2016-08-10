# --------------------------------
# SHOW
# --------------------------------
class App.VehicleShow
  constructor: () ->
    @element = $('#js-attachments')
    $('#js-progress-bar').hide()
    @bindEvents()
    @selectAttachment()

  bindEvents: ->
    $('#fileupload').fileupload
      dataType: 'script'
      start: ->
        $('#js-progress-bar').show()
        $('#js-progress-bar').find('.progress-bar').css('width', '0%')
      progressall: (e, data)->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $('#js-progress-bar').find('.progress-bar').css('width', "#{progress}%")
      fail: ->
        App.flash_snackbar_render
          danger: 'Falló la carga de imágenes'
      always: ->
        $('#js-progress-bar').hide()

    $('.carousel-control.left').click (e)=>
      @element.carousel('prev')
    $('.carousel-control.right').click (e)=>
      e.preventDefault()
      @element.carousel('next')

  selectAttachment: (attachment_id)->
    @showOrHideCarousel()

    @element.find('.item').removeClass('active')
    if attachment_id
      item = $("#attachment_#{attachment_id}")
    else
      item = $('#js-attachments').find('.item').first()
    item.addClass('active')

  showOrHideCarousel: ->
    if @element.find('.item').length == 0
      @element.hide()
    else
      @element.show()

  removeAttachment: (attachment_id)->
    $("#attachment_#{attachment_id}").remove()
    @selectAttachment()

# --------------------------------
# FORM
# --------------------------------
class App.VehicleForm

  constructor: () ->
    @bindEvents()
    @customer_modal       = new App.CustomerModalForm('#js-modal', @onCustomerCreated)
    @vehicle_model_select = new App.VehicleModelSelect('#js-vehicle-model')
    @version_select       = new App.VersionSelect('#js-version')
    @brand_select       = new App.BrandSelect('#js-brand')

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()

    $('#js-brand').on 'select2-selecting', (e)=>
      @onBrandChanged e.object

    $('#js-vehicle-model').on 'select2-selecting', (e)=>
      @onVehicleModelChanged e.object

    $('#js-version').on 'select2-selecting', (e)=>
      @onVersionChanged e.object

  onBrandChanged: (brand)->
    if brand.isNew
      @createBrand(brand.name)

    @vehicle_model_select.update(brand.id)
    $('#js-vehicle-model').val('')
    @version_select.update $('#js-vehicle-model').val()
    $('#js-version').val('')

  onVehicleModelChanged: (model)->
    if model.isNew
      @createVehicleModel(model.name)

    @version_select.update(model.id)
    $('#js-version').val('')

  onVersionChanged: (version)->
    if version.isNew
      @createVersion(version.name)

  onCustomerCreated: (data) ->
    $('input[data-behavior~=searchCustomer]').select2('data', data)


  createBrand: (name)->
    $.ajax
      url: '/brands'
      method: 'post'
      data:
        brand:
          name: name
      success: (data) =>
        @brand_select.update data.data.id, name

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
class App.BrandSelect

  constructor: (element_id) ->
    @element = $(element_id)
    @build_select()

  build_select: ->
    @element.normalSelect
      data: @element.data('data')
      placeholder: 'Buscar Marca...'
      createSearchChoicePosition: 'bottom'
      createSearchChoice: (term, page) ->
        unless page.some(((item) ->
            item.text.toLowerCase() == term.toLowerCase()
          ))
          return {
            id: term
            text: "#{term} (Nuevo)"
            name: term
            isNew: true
          }
  update: (brand_id, brand_name) ->
    brands = @element.data 'data'
    brands.push { id: brand_id, text: brand_name }
    @element.data('data', brands)
    @build_select()
    @element.select2('val', brand_id)
#
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
    createSearchChoicePosition: 'bottom'
    createSearchChoice: (term, page)->
      unless page.some(((item) ->
          item.text.toLowerCase() == term.toLowerCase()
        ))
        return {
          id: term
          text: "#{term} (Nuevo)"
          name: term
          isNew: true
        }

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
      createSearchChoicePosition: 'bottom'
      createSearchChoice: (term, page)->
        unless page.some(((item) ->
            item.text.toLowerCase() == term.toLowerCase()
          ))
          return {
            id: term
            text: "#{term} (Nuevo)"
            name: term
            isNew: true
          }

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

# ---------------------------------




# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  vehicle_form = new App.VehicleForm() unless $(".vehicles.new, .vehicles.edit, .vehicles.create, .vehicles.update").length == 0
  App.vehicle_show = new App.VehicleShow() unless $(".vehicles.show").length == 0
