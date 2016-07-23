# --------------------------------
# CATEGORY MODAL
# --------------------------------
class App.ExpenseCategoryModalForm

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
        name: "#{data.data.name}"

      @callback? newData

      $(@modal).modal('hide')
    else
      App.show_form_error_messages("ExpenseCategory", form, data.error_messages)
      $(@modal).modal('handleUpdate')


# --------------------------------
# FORM
# --------------------------------
class App.ExpenseForm

  constructor: () ->
    @bindEvents()
    @expense_category_modal = new App.ExpenseCategoryModalForm('#js-modal', @onExpenseCategoryCreated)

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchExpenseCategory]").ajaxSelect()

  onExpenseCategoryCreated: (data) ->
    $('input[data-behavior~=searchExpenseCategory]').select2('data', data)


# ---------------------------------
# --------------------------------
$(document).on "page:change", ->
  expense_form = new App.ExpenseForm() unless $(".expenses.new, .expenses.edit, .expenses.create, .expenses.update").length == 0
