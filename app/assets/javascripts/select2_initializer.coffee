jQuery.fn.ajaxSelect = (options) ->
  url = $(this).data('url')

  defaults =
    placeholder: "Buscar..."
    formatNoMatches: 'No hay resultados'
    formatSearching: "Buscando..."
    formatAjaxError: 'Falló la carga'
    formatInputTooShort: (term, minimum)->
      "Por favor ingrese al menos #{minimum} caracteres"
    allow_clear: true
    formatNoMatches: 'No hay resultados'
    formatter: (record) ->
      record.full_text || record.name
    result_formatter: (record, container, query, escapeMarkup) ->
      markup = []
      text = settings.format_name(record)
      Select2.util.markMatch(text, query.term, markup, escapeMarkup)
      markup = markup.join("")
      markup = "<div class='select2-main-text'> #{markup} </div>"
      if record.extra
        markup += settings.format_extra(record)

      return markup
    format_name: (record) ->
      record.full_text || record.name
    format_extra: (record) ->
      return "<small class='select2-extra-text'> #{record.extra} </small>"

    selectData: (term, page)->
      query: term
      limit: 10
      page: page

  settings = $.extend(defaults, options)

  this.select2
    initSelection: (elm, callback) ->
      data =
        id: $(elm).data "record-id"
        name: $(elm).data "record-text"
      callback(data)
    placeholder: settings.placeholder
    formatNoMatches: settings.formatNoMatches
    formatSearching: settings.formatSearching
    formatAjaxError: settings.formatAjaxError
    formatInputTooShort: settings.formatInputTooShort
    allowClear: settings.allow_clear
    minimumInputLength: 3
    ajax:
      url: url
      dataType: "jsonp"
      quietMillis: 100
      data: (term, page) ->
        settings.selectData(term, page)
      results: (data, page) ->
        more = (page * 10) < data.total

        results: data.records
        more: more
    formatResult: settings.result_formatter
    formatSelection: settings.formatter


jQuery.fn.normalSelect = (options) ->
  defaults =
    placeholder: 'Buscar...'
    allow_clear: true
    formatNoMatches: 'No hay resultados'
    formatSearching: "Buscando..."
    formatAjaxError: 'Falló la carga'
    formatInputTooShort: (term, minimum)->
      "Por favor ingrese al menos #{minimum} caracteres"

  settings = $.extend(defaults, options)
  $(this).select2 settings

