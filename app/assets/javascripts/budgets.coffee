class App.BudgetPrinter
  constructor: () ->
    print_url = $('#js-print-budget')
    console.log(print_url)
    return unless print_url
    window.open print_url.val(), '_blank'

# --------------------------------
# --------------------------------
$(document).on "page:change", ->
  new App.BudgetPrinter() unless $(".budgets.index").length == 0
