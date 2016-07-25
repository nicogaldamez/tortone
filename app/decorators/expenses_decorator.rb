# Decorates a bunch of expenses as a collection
# Check ExpenseDecorator to see an individual expense
class ExpensesDecorator < Draper::CollectionDecorator
  
  def total
    total = object.reduce(0) { |sum, e| sum + e.amount }
    h.number_to_currency(total, precision: 2)
  end
end