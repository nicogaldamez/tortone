class ExpenseFilter

  include ActiveModel::Model
  attr_accessor :from, :to, :expense_category

  def initialize(params)
    @from             = _from(params[:from], params[:skip_defaults])
    @to               = _to(params[:to], params[:skip_defaults])
    @expense_category = params[:expense_category]
  end

  def call(context=false)
    expenses.includes(:expense_category)
  end

  def total
    return 0 unless expenses.any?
    expenses.sum(:amount_in_cents) / 10_000
  end

  def expenses
    expenses = Expense.all
    expenses = expenses.where('incurred_on >= ?', @from) if @from.present?
    expenses = expenses.where('incurred_on <= ?', @to) if @to.present?
    expenses = expenses.joins(:expense_category).where('expense_categories.name ILIKE ?', "%#{@expense_category}%") if @expense_category.present?
    expenses
  end


  private

  def _from(from, skip_defaults=false)
    from ? from.to_date : Time.zone.today.beginning_of_month
    if from
      return from.to_date
    else
      skip_defaults ? nil : Time.zone.today.beginning_of_month
    end
  end

  def _to(to, skip_defaults=false)
    if to
      return to.to_date
    else
      skip_defaults ? nil : Time.zone.today.end_of_month
    end
  end

end
