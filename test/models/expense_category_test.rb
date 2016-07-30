# == Schema Information
#
# Table name: expense_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#

require 'test_helper'
require 'pp'

class ExpenseCategoryTest < ActiveSupport::TestCase

  def setup
    @expense_category = expense_categories(:car_wash)
  end

  test "should not save expense without name" do
    @expense_category.name = nil
    @expense_category.valid?
    assert_includes @expense_category.errors[:name], 'no puede estar en blanco'
  end

  test "should not save expense with duplicated name" do
    new_expense_category = ExpenseCategory.new(name: @expense_category.name)
    new_expense_category.valid?
    assert_includes new_expense_category.errors[:name], 'ya está en uso'
  end
  
end

