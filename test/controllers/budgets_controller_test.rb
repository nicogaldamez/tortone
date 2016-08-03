 'test_helper'

class BudgetsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    Prawn::Font::AFM.hide_m17n_warning = true
    @budget = budgets(:my_car)
    @budget_new_data = {
      vehicle_id: vehicles(:batmobile).id,
      year: 2014,
      vehicle_description: 'Volkswagen bora - cc',
      price: 120000,
      minimum_advance: 1000,
      financed: '10000',
      installments: '10',
      installments_cost: '1000',
      expenses: '10',
      notes: 'Nota nueva',
      budgeted_on: Date.yesterday
    }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Budget.count, assigns(:presenter).send(:budgets).send(:count)
  end

  test "should filter budgets by from date" do
    get :index, budget_filter: {from: Time.zone.yesterday.strftime('%Y-%m-%d') }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:budgets).send(:count)
    assert_includes assigns(:presenter).send(:budgets), budgets(:zero_km).decorate
  end

  test "should filter budgets by to date" do
    get :index, budget_filter: {to: Time.zone.yesterday.strftime('%Y-%m-%d') }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:budgets).send(:count)
    assert_includes assigns(:presenter).send(:budgets), budgets(:my_car).decorate
  end

  test 'should fill form with vehicle data' do
    vehicle = vehicles(:delorean).decorate
    get :new, vehicle_id: vehicle.id
    assert_not_nil assigns(:budget)

    assert_select 'input#budget_vehicle_id' do
      assert_select "[value=?]", vehicle.id.to_s
    end
    assert_select 'input#budget_budgeted_on' do
      assert_select "[value=?]", Time.zone.today.to_s
    end
    assert_select 'input#budget_vehicle_description' do
      assert_select "[value=?]", vehicle.identification
    end
    assert_select 'input#budget_year' do
      assert_select "[value=?]", vehicle.year.to_s
    end
    assert_select 'input#budget_price' do
      assert_select "[value=?]", vehicle.unformatted_price.to_s
    end
    assert_select 'input#budget_minimum_advance' do
      assert_select "[value=?]", vehicle.unformatted_minimum_advance.to_s
    end
  end

  test "should create budget" do
    assert_difference('Budget.count', 1) do
      post :create, budget: @budget_new_data
    end
    assert_redirected_to budgets_path(print: Budget.last.id)

    Budget.find_by(vehicle_description: @budget_new_data[:vehicle_description]).as_json.each do |key, value|
      assert_equal @budget_new_data[key.to_sym], value if @budget_new_data.key?(key.to_sym)
    end
  end

  test "should get budget" do
    get :show, id: @budget
    assert_equal @budget, assigns(:budget)
  end

  test "should get edit budget" do
    get :edit, id: @budget
    assert_equal @budget, assigns(:budget)
  end

  test "should update budget" do
    assert_record_differences(@budget, @budget_new_data) do
      put :update, id: @budget.id, budget: @budget_new_data
    end
    assert_redirected_to budgets_path(print: @budget.id)
  end

  test "should destroy budget" do
    assert_difference('Budget.count', -1) do
      delete :destroy, id: @budget.id
    end

    assert_redirected_to budgets_path
  end


end

