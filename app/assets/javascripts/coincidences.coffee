class App.Coincidences

  constructor: () ->
    @bindEvents()

  # Binding de Eventos
  bindEvents: () ->
    $.ajax "/coincidences",
      type: 'GET'
      dataType: 'json'
      success: (data) ->
        $("#js-coincidences").html(data.length) if data.length > 0




# --------------------------------
$(document).on "page:change", ->
  new App.Coincidences unless $(".user_sessions.new").length == 1
