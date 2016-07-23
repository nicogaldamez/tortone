class ExpenseCategoriesController < ApplicationController

  before_filter :set_expense_category, only: [:edit, :update, :destroy]

  # GET /expense_categories/new
  def new
    @modal_form = params[:modal] || false
    @expense_category = ExpenseCategory.new
    if @modal_form
      render :new, layout: nil
    else
      render :new
    end
  end

  # POST /expense_categories
  def create
    @expense_category = ExpenseCategory.new(expense_category_params)
    respond_to do |format|
      if @expense_category.save
        format.html { redirect_to expense_category_path, notice: 'La categoría ha sido creada correctamente.' }
        format.json { render json: {result: 'success', data: @expense_category} }
      else
        format.html { render :new }
        format.json { render json: {result: 'error', error_messages: @expense_category.errors, full_error_messages: @expense_category.errors.full_messages} }
      end
    end
  end

  # GET /expense_categories/search
  def search
    block = ->(expense_category) { { id: expense_category.id, name: expense_category.name } }
    records = RecordSearcher.call(ExpenseCategory, params, &block)
    render json: records.to_json, callback: params[:callback]
  end


  private

  def expense_category_params
    params.require(:expense_category).permit(:name, :description)
  end

  def set_expense_category
    @expense_category = ExpenseCategory.find(params[:id])
  end

end
