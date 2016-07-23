class ExpenseDecorator < Draper::Decorator
  delegate_all

  def amount
    h.number_to_currency(object.amount, precision: 2)
  end
  
  def expense_category
    object.expense_category.name
  end
  
  def description
    object.description || '-'
  end

end
