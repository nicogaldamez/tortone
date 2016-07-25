class ExpensesController < ApplicationController
  
  before_filter :set_expense, only: [:edit, :update, :destroy]
  
  # GET /expenses/new
  def new
    @expense = Expense.new(incurred_on: Time.zone.today)
  end
  
  # GET /expenses
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
  
  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path,
        notice: 'El gasto ha sido actualizado correctamente.'
    else
      render :edit
    end
  end
  
  # DELETE /expenses/:id
  def destroy
    if @expense.destroy
      redirect_to expenses_path,
        notice: 'El gasto ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el gasto'
      redirect_to expenses_path
    end
  end


  private
  
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:incurred_on, :expense_category_id, :amount, :description)
  end

end
