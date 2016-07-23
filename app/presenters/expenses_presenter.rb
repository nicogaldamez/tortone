class ExpensesPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def expenses
    @expenses ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= ExpenseFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:expense_filter]
      parameters = @params.require(:expense_filter).permit(:from, :to, :expense_category)
    end
    parameters || {}
  end

end
