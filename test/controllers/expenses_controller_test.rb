require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @expense = expenses(:peugeot_wash)
    @expense_new_data = {  
                          amount: 100.0,
                          expense_category_id: expense_categories(:advertising).id,
                          incurred_on: Date.today
                        }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:expenses_presenter)

    assert_equal Expense.count, assigns(:expenses_presenter).send(:expenses).send(:count)
  end


  test "should filter expenses by category" do
    get :index, expense_filter: {expense_category: @expense.expense_category.name}
    assert_response :success
    
    assert_equal 1, assigns(:expenses_presenter).send(:expenses).send(:count)
    assert_includes assigns(:expenses_presenter).send(:expenses), @expenses.decorate
  end

  test "should filter expenses by date" do
    get :index, expense_filter: {from: @expense.incurred_on, to: @expense.incurred_on}
    assert_response :success
    
    assert_equal 1, assigns(:expenses_presenter).send(:expenses).send(:count)
    assert_includes assigns(:expenses_presenter).send(:expenses), @expense.decorate
  end

  test "should get new expense" do
    get :new
    assert_not_nil assigns(:expense)
  end

  test "should create expense" do
    assert_difference('Expense.count', 1) do
      post :create, expense: @expense_new_data
    end
    new_expense = Expense.find_by(incurred_on: @expense_new_data[:incurred_on])

    assert_redirected_to expenses_path

    new_expense.as_json.each do |key, value|
      assert_equal @expense_new_data[key.to_sym], value if @expense_new_data.key?(key.to_sym)
    end
  end

  test "should get edit expense" do
    get :edit, id: @expense
    assert_equal @expense, assigns(:expense)
  end

  test "should update expense" do
    assert_record_differences(@expense, @expense_new_data) do
      put :update, id: @expense.id, expense: @expense_new_data
    end
    assert_redirected_to expenses_path
  end

  test "should destroy expense" do
    assert_difference('Expense.count', -1) do
      delete :destroy, id: @expense.id
    end

    assert_redirected_to expenses_path
  end

end
