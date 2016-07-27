class BudgetsController < ApplicationController

  before_filter :set_budget, only: [:edit, :update, :destroy]

  # GET /budgets
  def index
    @presenter = BudgetsPresenter.new(params)
    @budget_to_print = params[:print]
  end

  def show
    @budget = Budget.find(params[:id])
    pdf = BudgetPdf.new(@budget, view_context)
    send_data pdf.render, filename: "presupuesto_#{@budget.budgeted_on}",
              type: 'application/pdf',
              disposition: 'inline'
  end

  # GET /budgets/new
  def new
    @budget = new_budget_from_vehicle
  end

  # POST /budgets
  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to budgets_path(print: @budget.id), notice: 'El presupuesto ha sido creado con éxito'
    else
      render :new
    end
  end

  # GET /budgets/:id/edit
  def edit
  end

  # PUT /budgets/:id
  def update
    if @budget.update(budget_params)
      redirect_to budgets_path(print: @budget.id),
        notice: 'El presupuesto ha sido actualizado correctamente.'
    else
      render :edit
    end
  end

  # DELETE /budgets/:id
  def destroy
    if @budget.destroy
      redirect_to budgets_path,
        notice: 'El presupuesto ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el presupuesto'
      redirect_to budgets_path
    end
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:vehicle_id, :vehicle_description, :price,
                                   :minimum_advance, :financed, :installments,
                                   :installments_cost, :expenses, :notes,
                                   :budgeted_on, :year)

  end

  def new_budget_from_vehicle
    if params[:vehicle_id]
      vehicle_decorator = Vehicle.find(params[:vehicle_id]).decorate
      Budget.new(
        vehicle_id:          vehicle_decorator.id,
        budgeted_on:         Time.zone.today,
        vehicle_description: vehicle_decorator.identification,
        year:                vehicle_decorator.year,
        price:               vehicle_decorator.unformatted_price,
        minimum_advance:     vehicle_decorator.unformatted_minimum_advance
      )
    else
      Budget.new(budgeted_on: Time.zone.today)
    end

  end
end
