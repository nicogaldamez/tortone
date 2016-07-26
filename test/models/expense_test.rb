require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase

  def setup
    @expense = expenses(:peugeot_wash)
  end

  test "should not save expense without amount" do
    @expense.amount_in_cents = ''
    @expense.valid?
    assert_includes @expense.errors[:amount_in_cents], 'no puede estar en blanco'
  end

  test "should not save expense without expense category" do
    @expense.expense_category = nil
    @expense.valid?
    assert_includes @expense.errors[:expense_category], 'no puede estar en blanco'
  end
  
end

