window.App ||= {}

App.flash_snackbar_render = (flashMessages) ->
  $.each flashMessages, (key, value) ->
    style = ''
    switch key
      when 'success'
        style = 'callout callout-success'
      when 'danger'
        style = 'callout callout-danger'
      when 'error'
        style = 'callout callout-danger'
      else
        style = 'callout'
        break
    $.snackbar
      content: value
      style: style
      timeout: 10000
    return
  return

App.checkAll = (element)->
  $("[data-behavior~=check_all]").click ->
    if $(@).data('check-children-of')
      checkboxes = $($(@).data('check-children-of')).find("input[type=checkbox]")
    else
      checkboxes = $("input[type=checkbox]")

    checkboxes.prop('checked', $(@).prop('checked'))

App.initSnackbar = ->
  if $('.snackbar-message').length > 0
    $('.snackbar-message').snackbar 'show'

App.initDatepicker = ->
  if $('.datepicker').length > 0
    $('.datepicker').datetimepicker
      icons:
        time: 'fa fa-clock-o'
        date: 'fa fa-calendar'
        up: 'fa fa-chevron-up'
        down: 'fa fa-chevron-down'
        previous: 'fa fa-chevron-left'
        next: 'fa fa-chevron-right'
        today: 'fa fa-bullseye'
        clear: 'fa fa-trash'
        close: 'fa fa-remove'
      format: 'DD-MM-YYYY'
      locale: 'es'

# Inicializa los modals con ajax
App.initModals = (parent) ->
  if parent
    links = parent.find('[data-behavior~=ajax-modal]')
  else
    links = $('[data-behavior~=ajax-modal]')

  links.on 'click', (e)->
    that = this
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      url: this.href
    .done (data)->
      modal = $(that.getAttribute('data-target'))
      modal.addClass(that.getAttribute('data-targetClass'))
      modal.find('.modal-content').html(data)
      modal.modal("show");
      App.initTooltips(modal)

    return


App.show_form_error_messages = (modelName, form, error_messages) ->
  # Si hay errores en el formulario actual, los elimino
  formsWithErrors = $(form).find('div.form-group.has-error')
  formsWithErrors.children('span.help-block').remove()
  formsWithErrors.children().unwrap()
  $(form).find('div.text-danger').children().unwrap()

  # Muestro los nuevos errores
  for key, value of error_messages
    # key mapea con el elemento que causó el error ya que éste tiene el atributo name="modelo[key]"
    # value es un arreglo de mensajes de error que ocurrieron en ese campo
    element = $(form).find("[name='#{modelName.toLowerCase()}[#{key}]']")
    label = $(form).find("label[for='#{element.attr('id')}']")

    element.wrap("<div class='form-group has-error'></div>")
    element.after("<span class='help-block'>&nbsp;#{value.join(', ')}</span>")

    label.wrap("<div class='text-danger'></div>")

App.initTooltips = (parent) ->
  elements = if parent then parent.find("a, span, i, div, td, h5") else $("a, span, i, div, td, h5")
  elements.tooltip()

App.init = ->
  # Turbolinks progress bar
  Turbolinks.enableProgressBar()

  # Snackbar
  App.initSnackbar()

  # Datepicker
  App.initDatepicker()

  # Ajax Modals
  App.initModals()

  App.initTooltips()

  # Sidebar
  $('[data-controlsidebar]').on 'click', ->
    change_layout $(this).data('controlsidebar')
    slide = !AdminLTE.options.controlSidebarOptions.slide
    AdminLTE.options.controlSidebarOptions.slide = slide
    if !slide
      $('.control-sidebar').removeClass 'control-sidebar-open'
    return

  # Select2
  $("select").normalSelect()

  # Reactivo eventos de AdminLTE porque se pierden con turbolinks
  $.AdminLTE.layout.activate()
  $.AdminLTE.tree('.sidebar')

  # Check/uncheck all
  App.checkAll()

  # Best in place
  $(".best_in_place").best_in_place()

  $('.sidebar li.active').closest('.treeview').addClass('active')

$(document).on "page:load", ->
  App.init()

$(document).on "page:change", ->
  App.initSnackbar()
  App.initModals()
  App.initDatepicker()
  App.checkAll()
  $("select").normalSelect()
  $(".best_in_place").best_in_place()


$(document).on 'flash:send', (e, flashMessages) ->
  App.flash_snackbar_render flashMessages
  return
