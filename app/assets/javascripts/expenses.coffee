# --------------------------------
# EXPENSE CATEGORY
# ---------------------------------
class App.ExpenseCategorySelect

  constructor: (element_id) ->
    @element = $(element_id)
    @build_select()

  build_select: ->
    @element.normalSelect
      data: @element.data('data')
      placeholder: 'Buscar Categoría...'
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
  update: (expense_category_id, expense_category_name) ->
    expense_categories = @element.data 'data'
    expense_categories.push { id: expense_category_id, text: expense_category_name }
    @element.data('data', expense_categories)
    @build_select()
    @element.select2('val', expense_category_id)


# --------------------------------
# FORM
# --------------------------------
class App.ExpenseForm

  constructor: () ->
    @bindEvents()
    @expense_category_select  = new App.ExpenseCategorySelect('#js-expense-category')

  # Binding de Eventos
  bindEvents: () ->
    $('#js-expense-category').on 'select2-selecting', (e)=>
      @onExpenseCategoryChanged e.object

  onExpenseCategoryChanged: (expense_category)->
    if expense_category.isNew
      @createExpenseCategory(expense_category.name)
  
  createExpenseCategory: (name)->
    $.ajax
      url: '/expense_categories'
      method: 'post'
      data:
        expense_category:
          name: name
      success: (data) =>
        @expense_category_select.update data.data.id, name


# ---------------------------------
# --------------------------------
$(document).on "page:change", ->
  expense_form = new App.ExpenseForm() unless $(".expenses.new, .expenses.edit, .expenses.create, .expenses.update").length == 0
