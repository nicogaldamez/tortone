class BudgetFilter

  include ActiveModel::Model
  attr_accessor :from, :to

  def initialize(params)
    @from             = params[:from]
    @to               = params[:to]
  end

  def call
    budgets = Budget.all
    budgets = budgets.where('budgeted_on >= ?', @from.to_date) if @from.present?
    budgets = budgets.where('budgeted_on <= ?', @to.to_date) if @to.present?
    budgets
  end
end
