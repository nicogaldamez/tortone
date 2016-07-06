class App.CustomerModalForm

  constructor: (@modal, @callback) ->
    @bindEvents()


  bindEvents: () ->
    that = @
    $(@modal).on 'show.bs.modal', (e) ->
      $(this).find('form').on 'ajax:success', (event, data, status, xhr) =>
        that.processReceivedData(this, data, status, xhr)


  processReceivedData: (form, data, status, xhr) ->
    if data.result == 'success'
      # Aplicar cambios en la ventana actual, y cerrar el modal
      newData =
        id: data.data.id
        name: "#{data.data.first_name} #{data.data.last_name}"

      @callback? newData

      $(@modal).modal('hide')
    else
      App.show_form_error_messages("Customer", form, data.error_messages)
      $(@modal).modal('handleUpdate')
