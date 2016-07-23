class ExpensesController < ApplicationController
  
  def new
    @expense = Expense.new(incurred_on: Time.zone.today)
  end

  def index
    @expenses_presenter = ExpensesPresenter.new(params)
  end

  # POST /expenses
  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      redirect_to expenses_path,
        notice: 'El gasto se ha creado exitosamente.'
    else
      flash[:error] = "Ha habido un error al crear el gasto. Comprueba que completaste los campos necesarios"
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:incurred_on, :expense_category_id, :amount, :description)
  end

end
