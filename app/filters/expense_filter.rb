class ExpenseFilter

  include ActiveModel::Model
  attr_accessor :from, :to, :expense_category
  
  def initialize(params)
    @from             = _from(params[:from])
    @to               = _to(params[:to])
    @expense_category = params[:expense_category]
  end

  def call(context=false)
    expenses = Expense.all
    expenses = expenses.where('incurred_on >= ? AND incurred_on <= ?', @from, @to)
    expenses = expenses.joins(:expense_category).where('expense_categories.name ILIKE ?', "%#{@expense_category}%") if @expense_category.present?

    expenses.includes(:expense_category)
  end
  
  
  private
  
  def _from(from)
    date = from ? from.to_date : Time.zone.today
    date.beginning_of_month
  end
  
  def _to(to)
    date = to ? to.to_date : Time.zone.today
    date.end_of_month
  end
end