class App.BudgetPrinter
  constructor: () ->
    print_url = $('#js-print-budget')
    return unless print_url.length > 0
    window.open print_url.val(), '_blank'

# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.BudgetPrinter() unless $(".budgets.index").length == 0
