class BudgetsPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def budgets
    @budgets ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= BudgetFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:budget_filter]
      parameters = @params.require(:budget_filter).permit(:from, :to)
    end
    parameters || {}
  end

end
