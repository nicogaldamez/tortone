require 'test_helper'

class BudgetTest < ActiveSupport::TestCase

  def setup
    @my_car_budget = budgets(:my_car)
    @zero_km_budget = budgets(:zero_km)
  end

  test 'should not save budget without vehicle description' do
    @my_car_budget.vehicle_description = ''
    @my_car_budget.valid?
    assert_includes @my_car_budget.errors[:vehicle_description], 'no puede estar en blanco'
  end

  test 'should not save budget without price' do
    @my_car_budget.price = nil
    @my_car_budget.valid?
    assert_includes @my_car_budget.errors[:price], 'no puede estar en blanco'
  end

  test 'should not save budget without budgeted on date' do
    @my_car_budget.budgeted_on = ''
    @my_car_budget.valid?
    assert_includes @my_car_budget.errors[:budgeted_on], 'no puede estar en blanco'
  end
end
