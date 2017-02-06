class App.SalesList

  constructor: () ->
    @bindEvents()

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchBrandAndModel]").ajaxSelect()
    $('.best_in_place').bind 'ajax:success', ->
      sale_id = $(@).closest('tr').data('sale-id')
      $.ajax
        url: "sales/#{sale_id}.js"

# --------------------------------
# FORM
# --------------------------------
class App.SaleForm

  constructor: () ->
    @bindEvents()
    @customer_modal = new App.CustomerModalForm('#js-modal', @onCustomerCreated)

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchCustomer]").ajaxSelect()

  onCustomerCreated: (data) ->
    $('input[data-behavior~=searchCustomer]').select2('data', data)

# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.SalesList() unless $(".sales.index").length == 0
  sale_form = new App.SaleForm() unless $(".sales.new, .sales.edit, .sales.create, .sales.update").length == 0
